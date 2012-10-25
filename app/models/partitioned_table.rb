class PartitionedTable < ActiveRecord::Base
  
  def PartitionedTable.raw_data(table_name)
    statement = "select * from #{table_name} limit 100"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    PartitionedTable.find_by_sql(sanitized).size > 0
  end
  
  def PartitionedTable.find_all_hosts
    statement = "select distinct host_name from http_access_entry_tables order by 1"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    PartitionedTable.find_by_sql(sanitized).collect do |row|
      row['host_name']
    end
  end
  
end