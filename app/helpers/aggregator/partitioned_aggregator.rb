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
  
end
