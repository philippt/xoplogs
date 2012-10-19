class AccessByServicePerMin < ActiveRecord::Base
  
  attr_accessible :log_ts, :service_name, :host_name, :failure_count, :success_count, :response_time_micros_avg
  
end
