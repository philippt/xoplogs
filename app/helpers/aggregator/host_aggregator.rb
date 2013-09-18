# aggregates the statistics from the access_by_service* tables into
# host-level statistics in the access_by_host* and access* tables
class HostAggregator
  
  def initialize
    
  end
  
  def run
    
    # lookup the current status of the aggregator
    status = AggregatorStatus.find(:first)
    if status == nil
      status = AggregatorStatus.new()
      status.last_aggregated_id = 0      
    end
    
    while (true) do
      
      status = AggregatorStatus.find(:first)
      if status == nil
        status = AggregatorStatus.new()
        status.last_aggregated_id = 0      
        status.aggregated_up_to = Time.at(0)
      end
      $logger.info("host aggregator looking for targets (last aggregation considered everything up to #{status.aggregated_up_to.utc})")

      start_ts = Time.now()
      
      hosts_to_update = HttpAccessEntryTable.find_recently_upgraded_service_stat_slabs(status.aggregated_up_to.utc)

      if hosts_to_update.size == 0
        $logger.info("no updated slabs found for aggregating...sleeping")
        sleep 10
      else
        hosts_to_update.each do |row|
          update_one_day_of_stats_for_host(row.host_name, Time.parse(row.the_day))
        end
        
        # re-generate total tables (mins, hours and days) for the affected days
        hosts_to_update.map do |row|
          row.the_day
        end.uniq.each do |the_day|
          update_one_day_of_totals(Time.parse(the_day))
        end
        
        $logger.info("finished aggregation run after #{Time.now() - start_ts} seconds")
        
        status.aggregated_up_to = start_ts.utc.strftime("%Y-%m-%d %H:%M:%S")        
        status.save
      end
      
    end
  end
  
  def update_one_day_of_totals(starting_from_timestamp)
    start_ts = starting_from_timestamp
    stop_ts = starting_from_timestamp + 24 * 60 * 60
    
    condition = "log_ts >= '#{start_ts.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_ts.strftime("%Y-%m-%d %H:%M:%S")}'"
    
    AccessPerMin.delete_all condition
    AccessPerHour.delete_all condition
    AccessPerDay.delete_all condition
    
    totals_by_minute = HttpAccessEntryTable.group_totals_by_minute(starting_from_timestamp)
    0.upto(23) do |hour|
      0.upto(59) do |minute|
        
        the_timestamp = Time.at(starting_from_timestamp + (hour * 60 + minute) * 60)
        
        new_row = AccessPerMin.new(
          :log_ts => the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
          :success_count => 0, 
          :failure_count => 0,
          :response_time_micros_avg => 0
        )
        
        if totals_by_minute.has_key?(the_timestamp)
          row = totals_by_minute[the_timestamp]
          new_row[:success_count] = row.success_sum
          new_row[:failure_count] = row.failure_sum
          new_row[:response_time_micros_avg] = row.the_avg
        end
        
        new_row.save
      end
    end
    
    grouped_by_hour = HttpAccessEntryTable.group_totals_by_hour(starting_from_timestamp)
    0.upto(23) do |hour|
      the_timestamp = Time.at(starting_from_timestamp + (hour * 60 * 60))
      new_row = AccessPerHour.new(
        :log_ts => the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
        :success_count => 0, 
        :failure_count => 0,
        :response_time_micros_avg => 0          
      )
      if grouped_by_hour.has_key?(the_timestamp)
        new_row[:success_count] = grouped_by_hour[the_timestamp].success_sum
        new_row[:failure_count] = grouped_by_hour[the_timestamp].failure_sum
        new_row[:response_time_micros_avg] = grouped_by_hour[the_timestamp].the_avg
      else
        $logger.debug("hit empty bucket at #{the_timestamp}")
      end
      new_row.save
    end
    
    totals_for_day = HttpAccessEntryTable.group_totals_by_day(starting_from_timestamp)
    row = totals_for_day.first 
    AccessPerDay.new(
      :log_ts => starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
      :success_count => row.success_sum, 
      :failure_count => row.failure_sum,
      :response_time_micros_avg => row.the_avg
    ).save()
    $logger.info "updated totals : #{row.success_sum} successful calls, #{row.failure_sum} failures between #{start_ts} and #{stop_ts}"
  end
  
  def update_one_day_of_stats_for_host(host_name, starting_from_timestamp)
    # delete old entries for this host
    start_ts = starting_from_timestamp
    stop_ts = starting_from_timestamp + 24 * 60 * 60
    host_condition = "host_name = '#{host_name}' and log_ts >= '#{start_ts.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_ts.strftime("%Y-%m-%d %H:%M:%S")}'"
    
    AccessByHostPerMin.delete_all host_condition
    AccessByHostPerHour.delete_all host_condition
    AccessByHostPerDay.delete_all host_condition
    
    # and regenerate the host statistics from the the service stats
    host_entries = HttpAccessEntryTable.group_service_stats_by_host(host_name, starting_from_timestamp)
    0.upto(23) do |hour|
      0.upto(59) do |minute|
        
        the_timestamp = Time.at(starting_from_timestamp + (hour * 60 + minute) * 60)
        
        new_row = AccessByHostPerMin.new(
          :host_name => host_name,
          :log_ts => the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
          :success_count => 0, 
          :failure_count => 0,
          :response_time_micros_avg => 0
        )
        
        if host_entries.has_key?(the_timestamp)
          row = host_entries[the_timestamp]
          new_row[:success_count] = row.success_sum
          new_row[:failure_count] = row.failure_sum
          new_row[:response_time_micros_avg] = row.the_avg
        end
        
        new_row.save
      end
    end
    
    # hours per host
    grouped_by_hour = HttpAccessEntryTable.group_host_stats_by_hour(host_name, starting_from_timestamp)
    0.upto(23) do |hour|
      the_timestamp = Time.at(starting_from_timestamp + (hour * 60 * 60))
      new_row = AccessByHostPerHour.new(
        :host_name => host_name,
        :log_ts => the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
        :success_count => 0, 
        :failure_count => 0,
        :response_time_micros_avg => 0          
      )
      if grouped_by_hour.has_key?(the_timestamp)
        new_row[:success_count] = grouped_by_hour[the_timestamp].success_sum
        new_row[:failure_count] = grouped_by_hour[the_timestamp].failure_sum
        new_row[:response_time_micros_avg] = grouped_by_hour[the_timestamp].the_avg
      else
        $logger.debug("hit empty bucket at #{the_timestamp}")
      end
      new_row.save
    end
    
    # per host and day
    # and update the daily stats from the hours
    stats_for_day = HttpAccessEntryTable.group_host_stats_by_day(host_name, starting_from_timestamp)
    row = stats_for_day.first 
    AccessByHostPerDay.new(
      :host_name => host_name,
      :log_ts => starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
      :success_count => row.success_sum, 
      :failure_count => row.failure_sum,
      :response_time_micros_avg => row.the_avg
    ).save()
    $logger.info "updated host stats for #{host_name} : #{row.success_sum} successful calls, #{row.failure_sum} failures between #{start_ts} and #{stop_ts}"
  end
  
end