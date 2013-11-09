class SlStatsPerDay < ActiveRecord::Base
  # attr_accessible :title, :body
  
  attr_accessible :log_ts, :host_name, :service_name, :debug_count, :info_count, :warn_count, :error_count
end
