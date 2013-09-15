class AggregatedController < ApplicationController
  
  def index
    @total_count = 0
    @entries = []
    
    with_aggregated_data { |x| x }
  end
  
  # the following methods are called from javascript in order to fetch data for
  # individual data lines (result is flot-style json)  
  def graph_request_count_success
    data = with_aggregated_data do |entry|
      entry.success_count
    end
    render_as_flot_json "successful requests", data
  end

  def graph_request_count_errors    
    data = with_aggregated_data do |entry|
      entry.failure_count
    end
    render_as_flot_json "failed requests", data
  end

  def graph_request_count_total
    data = with_aggregated_data do |entry|
      entry.success_count + entry.failure_count
    end
    render_as_flot_json "all requests", data
  end

  def graph_response_time
    data = with_aggregated_data do |entry|
      entry.response_time_micros_avg / 1000
    end
    render_as_flot_json "response time", data
  end
  
  def get_data
    throw Exception.new("no such line : '#{params["line"]}'") unless lines.has_key?(params["line"])
    decorator_block = lines[params["line"]]
    data = with_aggregated_data do |entry|
      decorator_block.call(entry)
    end
    render :json => data
  end
  
  # examines the time range parameters and returns
  # the class name of the Model object where data should be retrieved from
  def examine_time_frame
    units = [
      #{:factor => 1, :name => "second"},
      {:factor => 60, :name => "min"},
      {:factor => 60, :name => "hour"},
      {:factor => 24, :name => "day"},
      #{:factor => 7, :name => "week"},
      #{:factor => 4, :name => "month"},
      #{:factor => 12, :name => "year"},
    ]

    desired_bucket_count = 50
    if (params.has_key?(:bucket_count))
      desired_bucket_count = params[:bucket_count].to_i
    end
    range_duration_secs = (@stop_ts.to_i - @start_ts.to_i)
    $logger.debug "desired bucket count : #{desired_bucket_count}"
    $logger.debug "range duration secs  : #{range_duration_secs}"

    # go through all units, starting from second, until we reached one that would give too few buckets
    current_bucket_count = range_duration_secs
    selected_unit = units[0]
    selected_interval_secs = 1
    units.each do |unit|
      break if (current_bucket_count / unit[:factor]) < desired_bucket_count
      current_bucket_count /= unit[:factor]
      selected_interval_secs *= unit[:factor]
      selected_unit = unit
    end

    $logger.debug "selected unit #{selected_unit[:name]} - bucket size in secs : #{selected_interval_secs}"

    # normalize start and stop parameters so that they match the selected bucket size
    interval = selected_interval_secs

    # move the start parameter backwards in time up to the next bucket limit
    @start_ts -= @start_ts.utc.sec if interval >= 60
    @start_ts -= @start_ts.utc.min * 60 if interval >= 60 * 60
    @start_ts -= @start_ts.utc.hour * 60 * 60 if interval >= 60 * 60 * 24

    # the stop parameter should be moved forward (we're extending the window)
    @stop_ts += 60 - @stop_ts.utc.sec if interval >= 60 and @stop_ts.utc.sec > 0
    @stop_ts += (60 - @stop_ts.utc.min) * 60 if interval >= 60 * 60 and @stop_ts.utc.min > 0
    @stop_ts += (24 - @stop_ts.utc.hour) * 60 * 60 if interval >= 60 * 60 * 24 and @stop_ts.utc.hour > 0

    $logger.debug "normalized start parameter : #{@start_ts.utc} (#{@start_ts.utc.to_i})"
    $logger.debug "normalized stop parameter : #{@stop_ts.utc} (#{@stop_ts.utc.to_i})"

    {
      :name_fragment => selected_unit[:name].capitalize,
      :bucket_size_secs => selected_interval_secs.to_i,
      :desired_bucket_count => desired_bucket_count
    }
  end
  
    # the data we fetched from the database might be incomplete, i.e. it's possible
  # that for some buckets there just isn't any data in the db
  # we want to display these buckets nevertheless, so we need to go through all
  # buckets and fill them with defaults if ncesessary
  def prepare_buckets(records, bucket_size_secs)
    # and hash it by timestamp
    record_by_ts = {}
    records.each do |row|
      the_timestamp = row.log_ts.utc
      #$logger.debug "found entry for #{the_timestamp} (#{the_timestamp.to_i})"
      record_by_ts[the_timestamp.utc.to_i] = row
    end

    #$logger.debug "from db : " + record_by_ts.keys.sort.join("\n")

    $logger.debug "got #{record_by_ts.keys.size} records from the db"
    expected_bucket_count = (@stop_ts.to_i - @start_ts.to_i) / bucket_size_secs
    $logger.debug "with a bucket size of #{bucket_size_secs}, we should have #{expected_bucket_count} buckets"

    buckets = []
    current_ts = @start_ts.utc.to_i
    $logger.debug "start_ts : #{@start_ts.to_i} (#{@start_ts})"
    while (current_ts < @stop_ts.utc.to_i)
      if record_by_ts.has_key?(current_ts)
        record = record_by_ts[current_ts]

        buckets << [
          record.log_ts.to_i * 1000,
          record
        ]
      else
        # create a dummy entry so that the block that has been passed can keep
        # on working as if there were data
        #$logger.debug "filling gap at #{current_ts} with default values"
        record = AccessPerDay.new(
          :success_count => 0,
          :failure_count => 0,
          :response_time_micros_avg => 1000
        )
        buckets << [
          current_ts * 1000,
          record
        ]
      end
      current_ts += bucket_size_secs
    end

    buckets
  end

  # now we've got a complete set of buckets, but probably there's too much data
  # in it - we picked the aggregation level closest to the desired bucket count,
  # but in order to hit exactly the bucket count, we'll have to aggregate some more
  def aggregate_buckets(buckets, the_model)
    #$logger.debug "got #{buckets.size} buckets : #{"\n" + buckets.join("\n")}"

    # we probably got a bit too much data now, aggregate
    result = []
    aggregation_factor = (buckets.size / the_model[:desired_bucket_count]).floor
    #$logger.debug "aggregating by factor #{aggregation_factor}"
    result << buckets.shift
    count = 1
    while buckets.size > 0 do
      if count >= aggregation_factor
        result << buckets.shift
        count = 1
      else
        # gonna merge this entry with the previous one
        moriturus = buckets.shift[1]
        previous_record = result.last[1]

        # TODO it might be a good idea to merge the timestamps as well

        # the count values can be summed up
        previous_record.success_count += moriturus.success_count
        previous_record.failure_count += moriturus.failure_count

        # the response time values need to averaged
        # TODO we need to handle the other response time values (min, max, stddev)
        if (previous_record.response_time_micros_avg || moriturus.response_time_micros_avg)
          previous_record.response_time_micros_avg ||= 0
          moriturus.response_time_micros_avg ||= 0
          new_response_time = (previous_record.response_time_micros_avg + moriturus.response_time_micros_avg)
          if (previous_record.response_time_micros_avg != 0 && moriturus.response_time_micros_avg != 0)
            new_response_time /= 2
            #$logger.debug("merging response time between #{previous_record.log_ts} and #{moriturus.log_ts}: #{previous_record.response_time_micros_avg} + #{moriturus.response_time_micros_avg} = #{new_response_time}")
          end
          previous_record.response_time_micros_avg = new_response_time
        end
        count += 1
      end
    end

    aggregated_bucket_size = the_model[:bucket_size_secs] * aggregation_factor
    result.each do |bucket|
      record = bucket[1]
      # normalize the counts to requests per minute
      record.success_count /= (aggregated_bucket_size / 60)
      record.failure_count /= (aggregated_bucket_size / 60)
    end

    result
  end

  
  # fetches the (aggregated) data specified through the request params and
  # executes the block on each row
  # the block's result is used as (y-axis) value in the graph (x-axis is time)
  def with_aggregated_data(&block)
    # first, we need to select where we'll get our data from
    timeframe = examine_time_frame

    aggregation_levels = {}

    class_name = "Access"

    if params.has_key?(:hosts)
      class_name = "AccessByHost"
      aggregation_levels[:host] = true
    end

    if params.has_key?(:services)
      class_name = "AccessByService"
      aggregation_levels[:service] = true
    end

    class_name += "Per" + timeframe[:name_fragment]
    $logger.debug "model to use : #{class_name}"

    # prepare the filters
    condition_string = " log_ts >= ? AND log_ts <= ? "
    condition_params = [ ]
    condition_params << @start_ts
    condition_params << @stop_ts

    if params[:hosts] and aggregation_levels.has_key?(:host)
      condition_string += " AND host_name IN (?)"
      condition_params << params[:hosts]
    end

    # service filter
    if params[:services]
      condition_string += " AND service_name IN (?)"
      condition_params << params[:services]
    end

    conditions = [ condition_string ]
    conditions += condition_params

    $logger.warn "conditions : #{conditions}"

    # fetch data from the database
    the_class = Kernel.const_get(class_name)
    records = the_class.find(
      :all,
      :conditions => conditions,
      :order => "log_ts desc"
      #:limit => dot_count
    )

    buckets = prepare_buckets(records, timeframe[:bucket_size_secs])
    #result = aggregate_buckets(buckets, timeframe)
    @buckets = buckets
    result = buckets

    # finally, let's extract from the buckets the data that's interesting for this graph
    result.each do |bucket|
      bucket[1] = yield(bucket[1])
    end

    result
  end
  
  def render_as_flot_json(title, data)
    render :json => {
      :data => data,
      :label => title,
      :lines => {
        :show => true,
      },
      :points => {
        :show => true
      }
    }
  end

  def lines
    {
      "count_success" => lambda { |entry|
        entry.success_count
      },
      "count_errors" => lambda { |entry| 
        entry.failure_count
      },
      "count_total" => lambda { |entry|
        entry.success_count + entry.failure_count
      },
      "response_time_ms" => lambda { |entry| 
        entry.response_time_micros_avg / 1000
      }
    }
  end
  
  def get_data
    data = {}
    params["line"].split(',').each do |line|
      raise "no such line : '#{line}'" unless lines.has_key? line
      
      decorator_block = lines[line]
      data[line] = with_aggregated_data do |entry|
        decorator_block.call(entry)
      end
    end
    render :json => data
  end
  
end
