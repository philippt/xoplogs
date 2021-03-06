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
  
  def self.aggregate(entries, log_type = "access", interval = :hour)
    raw = {}

    entries.each do |entry|
      if entry
	corrected_timestamp = entry[:log_ts].to_i
        if %w|hour day week|.include? interval
          corrected_timestamp -= entry[:log_ts].sec
        end
        if %w|day week|.include? interval
          corrected_timestamp -= entry[:log_ts].min * 60
        end
        if %w|week|.include? interval
          corrected_timestamp -= entry[:log_ts].hour * 60 * 60
        end
	  
	selector = if (log_type == 'access' || log_type == 'vop')
	  (entry[:return_code].to_i < 400) ? :success : :failure
	elsif log_type == 'server_log'
	  entry[:log_level]
	end
	raise "[woopsie] no selector found - that's probably a bug" unless selector
	  
	raw[selector] = {} unless raw.has_key? selector
	hash = raw[selector]
	
	hash[corrected_timestamp] = [] unless hash.has_key? corrected_timestamp
	hash[corrected_timestamp] << entry
      else
	$logger.warn("nil entry")
      end
    end

    aggregated = {}

    raw.each do |selector, e|
      e.keys.sort.each do |bucket|
	aggregated[selector] = [] unless aggregated.has_key? selector
	aggregated[selector] << [
	  bucket, e[bucket].size          
	]
      end
    end

    out_count = 0
    raw[:success].keys.sort.each do |ts|
      bucket = raw[:success][ts]
      total = 0
      count = 0
      bucket.each do |entry|
	if entry[:response_time_microsecs]
	  count += 1
	  total += entry[:response_time_microsecs].to_i / 1000
	end
      end
      avg = total / count
      if out_count < 5
	puts "total for #{Time.at(ts)} : #{total}, count #{count} of #{bucket.size}. avg: #{avg}"
        out_count += 1
      end

      aggregated['response_time_ms'] ||= []
      aggregated['response_time_ms'] << [
        ts, avg
      ]
    end unless raw[:success] == nil

    aggregated
  end
  
end
