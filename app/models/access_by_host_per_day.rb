class AccessByHostPerDay < ActiveRecord::Base

   def self.find_distinct(start_ts, stop_ts, column_name)
    conditions = ["select distinct #{column_name} from #{self.table_name} where log_ts >= from_unixtime(?) and log_ts <= from_unixtime(?) order by #{column_name}"]
    conditions << start_ts.to_i
    conditions << stop_ts.to_i
    sanitized = ActiveRecord::Base.sanitize_sql_array(conditions)
    HttpAccessEntry.find_by_sql(sanitized).collect do |row|
      row[column_name]
    end
  end

end
