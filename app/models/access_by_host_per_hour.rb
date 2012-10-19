class AccessByHostPerHour < ActiveRecord::Base
  
  attr_accessible :log_ts, :host_name, :service_name, :success_count, :failure_count, :response_time_micros_avg
  
end
