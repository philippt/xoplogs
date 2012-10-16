class HttpAccessEntry < ActiveRecord::Base

  DEFAULT_PAGESIZE = 50

  def HttpAccessEntry.set_defaults(from, to, params)
    from ||= Time.now() - (60 * 60 * 2)
    to ||= Time.now()
  end

  def HttpAccessEntry.conditions_from_params(from, to, params)
    condition_string = ""
    args = []

    set_defaults(from, to, params)

    condition_string += "log_ts >= ? and log_ts <= ? "
    $logger.debug "filtering between #{from} and #{to}"
    args << from
    args << to

    # host filter
    if params[:hosts]
      condition_string += " and host_name in (?)"
      args << params[:hosts]
    end

    # service filter
    if params[:services]
      condition_string += " and service_name in (?)"
      args << params[:services]
    end

    # http host filter
    if params[:http_hosts]
      condition_string += " and http_host_name in (?)"
      args << params[:http_hosts]
    end

    # return code
    if params[:return_code] && params[:return_code] != nil && params[:return_code] != ""
      condition_string += " and return_code in (?)"
      args << params[:return_code].split(/,/)
    end
    
    if params[:method_name] && params[:method_name] != nil && params[:method_name] != ""
      condition_string += " and method_name LIKE ?"
      args << '%' + params[:method_name] + '%'
    end

    if params[:method_name_exact] && params[:method_name_exact] != nil && params[:method_name_exact] != ""
      condition_string += " and method_name = ?"
      args << params[:method_name_exact]
    end
    
    if params[:source_ip] && params[:source_ip] != nil && params[:source_ip] != ""
      condition_string += " and source_ip = ?"
      args << params[:source_ip]
    end

    # assemble the result (first condition_string, then the params for bind variables)
    result = []
    result << condition_string
    result += args
    $logger.debug "conditions : #{result}"
    result
  end

  def HttpAccessEntry.find_raw(from = Time.at(0), to = Time.now(), params = {})
    pagesize = params.has_key?(:page_size) && params[:page_size] != "" ? params[:page_size] : DEFAULT_PAGESIZE
    page = params.has_key?(:page) ? params[:page].to_i : 1

    HttpAccessEntry.find(
      :all,
      :conditions => conditions_from_params(from, to, params),
      :order => 'log_ts',
      :limit => pagesize,
      :offset => pagesize * (page - 1)
    )
  end

  def HttpAccessEntry.extract_interval(from, to, params)
    desired_bucket_count = 20.0
    if (params.has_key?(:bucket_count))
      desired_bucket_count = params[:bucket_count]
    end
    range_duration_mins = (to.to_i - from.to_i) / 60
    $logger.debug  "duration in minutes : #{range_duration_mins}"
    bucket_width = range_duration_mins / desired_bucket_count
    $logger.debug  "bucket width : #{bucket_width}"

    {
      :time_columns => "floor((unix_timestamp(log_ts) - unix_timestamp('#{from.strftime("%Y-%m-%d %H:%M:%S")}')) / #{bucket_width * 60})",
      :bucket_distance => bucket_width
    }
  end
  
  def HttpAccessEntry.pick_time_columns(from, to, params = {})
    units = [
      {:factor => 1, :name => "second"},
      {:factor => 60, :name => "minute"},
      {:factor => 60, :name => "hour"},
      {:factor => 24, :name => "day"},
      {:factor => 7, :name => "week"},
      {:factor => 4, :name => "month"},
      {:factor => 12, :name => "year"},
    ]

    desired_bucket_count = 20.0
    if (params.has_key?(:bucket_count))
      desired_bucket_count = params[:bucket_count]
    end
    range_duration_secs = (to.to_i - from.to_i)
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

    # assemble the column names for the SELECT and GROUP BY clauses
    column_names = []
    units.reverse.each do |unit|
      column_names << unit[:name]
      break if unit == selected_unit
    end

    {
      :bucket_count => desired_bucket_count,
      :distance_secs => selected_interval_secs,
      :selected_interval => selected_unit[:name],
      :time_columns => column_names.collect{ |name| name + '(log_ts)'  }.join(', '),
      :time_columns_with_names => column_names.collect{ |name| name + '(log_ts) the_' + name  }.join(', '),
    }
    
  end

  def HttpAccessEntry.normalize_start_param(interval, from)
    # now that we know the bucket size, normalize the start parameter
    from -= from.sec if interval >= 60
    from -= from.min * 60 if interval >= 60 * 60
    from -= from.hour * 60 * 60 if interval >= 60 * 60 * 24

    # TODO complete this

    from
  end

  def HttpAccessEntry.requests_per_minute(from, to, params = {})
    $logger.debug "+++ requests_per_minute (from : #{from}, to : #{to}, params : #{params}) +++"
    set_defaults(from, to, params)
    interval = pick_time_columns(from, to, params)

    # now that we know the bucket size, normalize the start parameter
    from = normalize_start_param(interval[:distance_secs], from)

    # assemble the statement
    conditions = conditions_from_params(from, to, params)
    conditions[0] =
      "select log_ts, #{interval[:time_columns_with_names]}, count(*) as the_count, avg(response_time_microsecs) as response_time " +
      "from http_access_entries " +
      "where " + conditions[0] + " " +
      "group by #{interval[:time_columns]} " +
      "order by 1, 2"
    sanitized = ActiveRecord::Base.sanitize_sql_array(conditions)
    $logger.debug  "sanitized : #{sanitized}"

    records = HttpAccessEntry.find_by_sql(sanitized)

    # hash the records by timestamp
    record_by_ts = {}
    records.each do |row|
      the_timestamp = row.log_ts

      the_timestamp = normalize_start_param(interval[:distance_secs], the_timestamp)

      record_by_ts[the_timestamp.to_i] = row
    end

    # now go over all buckets and use either the row or a default
    target = []
    current_start = from
    while current_start < to
      if record_by_ts.has_key?(current_start.to_i)
        target << {
          "epoch" => current_start,
          "request_count" => record_by_ts[current_start.to_i].the_count.to_i,
          "response_time" => record_by_ts[current_start.to_i].response_time.to_i
        }
      else
        target << {
          "epoch" => current_start,
          "request_count" => 0
        }
      end

      current_start += interval[:distance_secs]
    end
    $logger.debug "got #{target.size} buckets in 'target' : #{"\n" + target.join("\n")}"

    # we probably got a bit too much data now, aggreate
    result = []
    aggregation_factor = (target.size / interval[:bucket_count]).floor
    $logger.debug "aggregating by factor #{aggregation_factor}"
    result << target.shift
    count = 1
    while target.size > 0 do
      if count >= aggregation_factor
        result << target.shift
        count = 1
      else
        moriturus = target.shift
        result.last["request_count"] += moriturus["request_count"]
        if (result.last["response_time"] || moriturus["response_time"])
          result.last["response_time"] ||= 0
          moriturus["response_time"] ||= 0
          new_response_time = (result.last["response_time"] + moriturus["response_time"])
          if (result.last["response_time"] != 0 && moriturus["response_time"] != 0)
            new_response_time /= 2
            $logger.debug("merging response time between #{result.last["epoch"]} and #{moriturus["epoch"]}: #{result.last["response_time"]} + #{moriturus["response_time"]} = #{new_response_time}")
          end
          result.last["response_time"] = new_response_time
        end
        count += 1
      end
    end

    # and remove all empty buckets from the end
    while (result.last != nil && result.last["request_count"] == 0)
      result.pop
    end

    $logger.debug "returning #{result.size} buckets : #{result}"

    result
  end

  def HttpAccessEntry.find_distinct(column_name)
    statement = "select distinct #{column_name} from http_access_entries order by #{column_name}"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    HttpAccessEntry.find_by_sql(sanitized).collect do |row|
      row[column_name]
    end
  end

  def HttpAccessEntry.stats_per_host_and_service
    statement = "select host_name, service_name, count(*) the_count, unix_timestamp(min(log_ts)) first_ts, unix_timestamp(max(log_ts)) last_ts " +
                "from http_access_entries " +
                "group by host_name, service_name " +
                "order by host_name, service_name"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    HttpAccessEntry.find_by_sql(sanitized)
  end

  # groups the entries of the specified timeframe by the selected group_fields
  # and returns for each group:
  #   request_count total number of requests performed
  #   avg_response_time
  #   min_response_time
  #   max_response_time
  #   first_ts
  #   last_ts
  # the sort column and direction can be specified through :sort_field/:sort_dir
  def HttpAccessEntry.grouped_stats(from, to, group_fields = [], params = {})
    conditions = conditions_from_params(from, to, params)
    sort_field = params[:sort_field] || "avg(response_time_microsecs)"
    sort_direction = params[:sort_dir] || "DESC"
    
    group_cols = group_fields.join(", ")
    
    new_conditions = []
    new_conditions <<
      "SELECT #{group_cols}, " +
        "count(*) as request_count, " +
        "avg(response_time_microsecs) as avg_response_time, " +
        "min(response_time_microsecs) as min_response_time, " + 
        "max(response_time_microsecs) as max_response_time, " +
        "unix_timestamp(min(log_ts)) first_ts, unix_timestamp(max(log_ts)) last_ts " +
      "FROM http_access_entries " +
      "WHERE " + conditions.shift + " " +
      "GROUP BY #{group_cols} " +
      "ORDER BY #{sort_field} #{sort_direction} " +
      "LIMIT 20"
    conditions.each do |cond|
      new_conditions << cond
    end

    sanitized = ActiveRecord::Base.sanitize_sql_array(new_conditions)
    $logger.debug  "sanitized : #{sanitized}"
    HttpAccessEntry.find_by_sql(sanitized)
  end

  # moves all entries older than two weeks into the archive table
  BATCH_SIZE = 500
  def HttpAccessEntry.move_to_archive()
    the_timestamp = Time.now() - 60 * 60 * 24 * 7 * 2 # 2 weeks
    $logger.info "moving all entries older than #{the_timestamp} into the archive"

    while (true) do
      conditions = "SELECT id FROM http_access_entries WHERE log_ts < FROM_UNIXTIME(#{the_timestamp.to_i}) LIMIT 500"
      sanitized = ActiveRecord::Base.sanitize_sql_array(conditions)
      $logger.debug  "sanitized : #{sanitized}"
      records = HttpAccessEntry.find_by_sql(sanitized)
      if (records.size() > 0)
        $logger.info "found #{records.size()} more entries for archiving..."

        records.each do |record|
          $logger.debug "archiving record #{record.id}"
          ActiveRecord::Base.connection.execute(
            "INSERT INTO http_access_entries_archive " +
            "SELECT * FROM http_access_entries " +
            "WHERE id = #{record.id}"
          )
          ActiveRecord::Base.connection.execute(
            "DELETE FROM http_access_entries " +
            "WHERE id = #{record.id}"
          )
        end
      else
        $logger.info "no more entries found that could be archived. my duty here is done."
        break
      end
    end
  end

  ### find()-style methods for access_* tables
  def HttpAccessEntry.stats_per_day
    conditions = "SELECT * FROM access_per_day"
    sanitized = ActiveRecord::Base.sanitize_sql_array(conditions)
    $logger.debug  "sanitized : #{sanitized}"
    records = HttpAccessEntry.find_by_sql(sanitized)

    records
  end

end
