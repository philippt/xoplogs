class AccessByServicePerDay < ActiveRecord::Base

   def self.find_for_lookup(start_ts, stop_ts, host_filter = nil)
     result = []
     statement = "SELECT DISTINCT host_name, service_name " +
                 "FROM #{self.table_name} " +
                 "WHERE log_ts >= FROM_UNIXTIME(?) AND log_ts <= FROM_UNIXTIME(?) "
     conditions = [start_ts.to_i, stop_ts.to_i]
     if (host_filter != nil) and (host_filter.size > 0)
       statement += "AND host_name in (?) "
       conditions << host_filter
     end
     statement += "ORDER BY host_name, service_name"
     conditions.unshift(statement)
     sanitized = ActiveRecord::Base.sanitize_sql_array(conditions)
     HttpAccessEntry.find_by_sql(sanitized).collect do |row|
       result << {
         "host_name" => row["host_name"],
         "service_name" => row["service_name"]
       }
     end
     result
  end

end
