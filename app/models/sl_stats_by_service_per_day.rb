class SlStatsByServicePerDay < ActiveRecord::Base
  # attr_accessible :title, :body
  
  def self.find_distinct(start_ts, stop_ts)
    conditions = ["select distinct host_name, service_name from #{self.table_name} where log_ts >= from_unixtime(?) and log_ts <= from_unixtime(?) order by host_name, service_name"]
    conditions << start_ts.to_i
    conditions << stop_ts.to_i
    sanitized = ActiveRecord::Base.sanitize_sql_array(conditions)
    SlStatsByServicePerDay.find_by_sql(sanitized).map do |row|
      {
         'host_name' => row['host_name'],
         'service_name' => row['service_name']
      }
    end
  end
end
