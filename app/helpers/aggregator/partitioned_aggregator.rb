class PartitionedAggregator
  
  # populates the access statistics tables
  # (aggregates data from http_access_entries into the access_* tables)
  def write_access_stats

    while (true) do
      # find a table that needs aggregation
      target_table = HttpAccessEntryTable.find_table_for_aggregator
      if target_table != nil
        $logger.info("aggregating table #{target_table.table_name}")
        
        target_table.update_stats
        
        $logger.info "table #{target_table.table_name} seems to have been aggregated completely."
        target_table.needs_aggregation = false
        target_table.active_aggregator_pid = nil
        target_table.last_aggregated_at = Time.now().utc
        #target_table.last_aggregated_at = Time.now().strftime("%Y-%m-%d %H:%M:%S")
        target_table.save
      else
        $logger.info("no tables found to aggregate - gonna sleep for 10 secs")
        sleep 10
      end
    end
  end
  
  def self.aggregate(entries)
    success_entries = entries.select { |x| x[:return_code] < 400 }
    failure_entries = entries.select { |x| x[:return_code] > 400 }
    
    by_minute = {}
    0.upto(23) do |hour|
      0.upto(59) do |minute|
        
        the_timestamp = Time.at(start_ts + (hour * 60 + minute) * 60)
        
        h = {
          :log_ts => the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
          :success_count => 0, 
          :failure_count => 0,
          :response_time_micros_avg => 0
        }
        if success_entries.has_key?(the_timestamp)
          h[:success_count] = success_entries[the_timestamp].the_count
          h[:response_time_micros_avg] = success_entries[the_timestamp].the_avg
        end
        if failure_entries.has_key?(the_timestamp)
          h[:failure_count] = failure_entries[the_timestamp].the_count
        end
        
        by_minute[the_timestamp] = h
      end
    end
  end
  
end
