# populates statistics tables:
#   aggregates from http access entries (hae) tables into access_by_service_* tables,
#         also from server log (sl) tables into sl_stats_by_service_*
class PartitionedAggregator
  
  def write_access_stats
    while (true) do
      [ HttpAccessEntryTable, ServerLogTable ].each do |x| 
        target_table = x.find_table_for_aggregator 
        if target_table != nil
          $logger.info("aggregating table #{target_table.table_name}")
          
          target_table.update_stats
          
          $logger.info "table #{target_table.table_name} seems to have been aggregated completely."
          target_table.needs_aggregation = false
          target_table.active_aggregator_pid = nil
          target_table.last_aggregated_at = Time.now().utc
          target_table.save
        else
          $logger.info("no #{x} tables found to aggregate")          
        end
      end
      $logger.info "gonna sleep for 10 secs"
      sleep 10
    end
  end
  
  def self.aggregate(entries, type = 'access')
    
    raw = {
    }
    
    entries.each do |entry|
      if entry != nil
        corrected_timestamp = entry[:log_ts].to_i - entry[:log_ts].min
        
        selector = if type == 'access'
          entry[:return_code].to_i < 400 ? :success : :failure
        elsif type == 'server_log'
          entry[:log_level]
        end
        
        raw[selector] = {} unless raw.has_key? selector
        hash = raw[selector]
        
        hash[corrected_timestamp] = [] unless hash.has_key? corrected_timestamp
        hash[corrected_timestamp] << entry
      else
        $logger.warn("nil entry")
      end
    end

    aggregated = {
    }

    raw.each do |selector, e|
      e.keys.sort.each do |minute|
        aggregated[selector] = [] unless aggregated.has_key? selector
        aggregated[selector] << [
          minute, e[minute].size          
        ]
      end
    end
    aggregated
  end
  
end
