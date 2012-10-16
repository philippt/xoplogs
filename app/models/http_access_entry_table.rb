class HttpAccessEntryTable < ActiveRecord::Base
  
  BATCH_SIZE = 10000
  RAW_DATA_ARCHIVE_DIR = $app_config.has_key?("raw_data_storage_path") ? $app_config["raw_data_storage_path"] : "#{ENV['HOME']}/raw_data_archive"
  
  DAYS_TO_KEEP = $app_config.has_key?("raw_data_storage_time_days") ? $app_config["raw_data_storage_time_days"].to_i : 7
    
  CREATE_STATEMENT = <<EOF
CREATE TABLE IF NOT EXISTS %s (
  id int(11) NOT NULL auto_increment,
  log_ts datetime default NULL,
  host_name varchar(200) default NULL,
  service_name varchar(200) default NULL,
  method_name varchar(200) default NULL,
  remote_ip varchar(20) default NULL,
  x_forwarded_for varchar(100) default NULL,
  source_ip varchar(20) default NULL,
  http_host_name varchar(200) default NULL,
  http_method varchar(10) default NULL,
  http_version varchar(10) default NULL,
  return_code int(11) default NULL,
  response_size_bytes int(11) default NULL,
  response_time_microsecs int(11) default NULL,
  user_agent varchar(200) default NULL,
  referrer varchar(200) default NULL,
  md5_checksum varchar(100) default NULL,
  created_at datetime default NULL,
  updated_at datetime default NULL,
  query_string varchar(1024) default NULL,
  aggregated_flag int(11) default NULL,
  PRIMARY KEY  (id),
  KEY index_http_access_entries_on_log_ts (log_ts),
  KEY index_http_access_entries_on_host_name (host_name),
  KEY index_http_access_entries_on_service_name (service_name),
  KEY index_http_access_entries_on_http_host_name (http_host_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

EOF

  def table_name
    'hae_' + self.host_name.gsub(".", "_") + '_' + self.service_name + '_' + self.the_day
  end
  
  def start_ts
    Time.parse(the_day)
  end
  
  def stop_ts
    Time.at(Time.parse(the_day).to_i + 24 * 60 * 60)
  end
  
  def standard_condition
    "host_name = '#{self.host_name}' and service_name = '#{self.service_name}' and log_ts >= '#{start_ts.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_ts.strftime("%Y-%m-%d %H:%M:%S")}'"
  end
  
  def HttpAccessEntryTable.table_exists(table_name)
    statement = "show tables like '#{table_name}'"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    HttpAccessEntryTable.find_by_sql(sanitized).size > 0
  end
  
  def HttpAccessEntryTable.find_all_hosts
    statement = "select distinct host_name from http_access_entry_tables order by 1"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    HttpAccessEntryTable.find_by_sql(sanitized).collect do |row|
      row['host_name']
    end
  end
  
  def HttpAccessEntryTable.grouped_data_columns
    "sum(success_count) success_sum, sum(failure_count) failure_sum, avg(response_time_micros_avg) the_avg"
  end
  
  # will update all access_by_service aggregation tables from this raw data table
  def update_stats    
    $logger.info "regenerating stats from #{self.table_name}..."
    
    # first delete the old data (always a good idea)
    AccessByServicePerMin.delete_all standard_condition    
    AccessByServicePerHour.delete_all standard_condition
    AccessByServicePerDay.delete_all standard_condition
      
    # and reconstruct from the raw data
    success_entries = get_grouped_entries
    failure_entries = get_grouped_entries(false)    
    
    # fill up gaps, merge the success and failure data and
    # write per-minute statistics
    0.upto(23) do |hour|
      0.upto(59) do |minute|
        
        the_timestamp = Time.at(start_ts + (hour * 60 + minute) * 60)
        
        new_row = AccessByServicePerMin.new(
          :host_name => self.host_name,
          :service_name => self.service_name,
          :log_ts => the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
          :success_count => 0, 
          :failure_count => 0,
          :response_time_micros_avg => 0
        )
        if success_entries.has_key?(the_timestamp)
          new_row[:success_count] = success_entries[the_timestamp].the_count
          new_row[:response_time_micros_avg] = success_entries[the_timestamp].the_avg
        end
        if failure_entries.has_key?(the_timestamp)
          new_row[:failure_count] = failure_entries[the_timestamp].the_count
        end
        new_row.save()
      end
    end
    
    # group the data we've just written by hour
    grouped_by_hour = get_hour_stats_from_minutes
    0.upto(23) do |hour|
      the_timestamp = Time.at(start_ts + (hour * 60 * 60))
      new_row = AccessByServicePerHour.new(
        :host_name => self.host_name,
        :service_name => self.service_name,
        :log_ts => the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
        :success_count => 0, 
        :failure_count => 0,
        :response_time_micros_avg => 0          
      )
      if grouped_by_hour.has_key?(the_timestamp)
        new_row[:success_count] = grouped_by_hour[the_timestamp].success_sum
        new_row[:failure_count] = grouped_by_hour[the_timestamp].failure_sum
        new_row[:response_time_micros_avg] = grouped_by_hour[the_timestamp].the_avg
      end
      new_row.save
    end
    
    # and update the daily stats from the hours
    row = get_daily_stats_from_hours.first 
    AccessByServicePerDay.new(
      :host_name => self.host_name,
      :service_name => self.service_name,
      :log_ts => start_ts.strftime("%Y-%m-%d %H:%M:%S"),
      :success_count => row.success_sum, 
      :failure_count => row.failure_sum,
      :response_time_micros_avg => row.the_avg
    ).save()
    $logger.info "updated stats for #{self.service_name}@#{self.host_name} : #{row.success_sum} successful calls, #{row.failure_sum} failures between #{start_ts} and #{stop_ts}"
  end
  
  def get_daily_stats_from_hours
    statement = 
      "select " + HttpAccessEntryTable.grouped_data_columns + " " +
      "from access_by_service_per_hours " +
      "where " + standard_condition
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    #$logger.debug(sanitized)
    
    AccessByServicePerHour.find_by_sql(sanitized)
  end
  
  def get_hour_stats_from_minutes
    statement = 
      "select " + HttpAccessEntryTable.grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour " +
      "from access_by_service_per_mins " +
      "where " + standard_condition + " " +
      "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts)"
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    result = {}
    HttpAccessEntry.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:00")
      result[timestamp] = row
    end
    result
  end
  
  def get_grouped_entries(success = true)
    conditions = [ 
      "SELECT year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour, minute(log_ts) the_minute, count(1) the_count, avg(response_time_microsecs) the_avg " + 
      "FROM #{table_name} " +
      "WHERE return_code " + (success ? "< 400" : ">= 400") + " " + 
      "GROUP BY year(log_ts), month(log_ts), day(log_ts), hour(log_ts), minute(log_ts) " +
      "ORDER BY log_ts"
    ]
    sanitized = HttpAccessEntryTable.sanitize_sql(conditions)
    result = {}
    HttpAccessEntry.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:#{row.the_minute}")
      result[timestamp] = row
    end
    result
  end
  
  #def HttpAccessEntryTable.sanitize_sql(conditions)
  #  ActiveRecord::Base.sanitize_sql_array(conditions)
  #end
    
  def HttpAccessEntryTable.find_table_for_aggregator    
    the_pid = Process.pid
    ActiveRecord::Base.connection.execute(
      "update http_access_entry_tables set active_aggregator_pid = #{the_pid} where needs_aggregation = 1 and active_aggregator_pid is null limit 1"
    )    
    
    the_table = HttpAccessEntryTable.find(
      :first,
      :conditions => [
        "active_aggregator_pid = ? AND needs_aggregation = 1", 
        the_pid
      ]
    )
    
    the_table
  end
  
  def find_entries_to_aggregate
    $logger.info "looking for entries to aggregate with id > #{self.last_aggregated_id} in table #{self.table_name}"
    HttpAccessEntryTable.find_entries_to_aggregate(self.last_aggregated_id, self.table_name)
  end
  
  def find_all_entries
    HttpAccessEntryTable.find_entries_to_aggregate(0, self.table_name)
  end
  
  def HttpAccessEntryTable.find_entries_to_aggregate(last_id, table_name)
    conditions = [ "SELECT * FROM #{table_name} WHERE id > ? LIMIT #{BATCH_SIZE}" ]
    conditions << last_id
    sanitized = ActiveRecord::Base.sanitize_sql_array(conditions)
    #$logger.debug  "sanitized : #{sanitized}"
    HttpAccessEntry.find_by_sql(sanitized)
  end
  
  def HttpAccessEntryTable.find_recently_upgraded_service_stat_slabs(newer_than_timestamp)
    statement = "select distinct host_name, the_day from http_access_entry_tables where needs_aggregation = 0 and last_aggregated_at is not NULL and last_aggregated_at >= '#{newer_than_timestamp.strftime("%Y-%m-%d %H:%M:%S")}'"
    $logger.info "sanitized : #{statement}"
    sanitized = ActiveRecord::Base.sanitize_sql_array(statement)
    HttpAccessEntryTable.find_by_sql(sanitized)
  end
  
  def HttpAccessEntryTable.group_service_stats_by_host(host_name, starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour, minute(log_ts) the_minute " +
    "FROM access_by_service_per_mins " +
    "where host_name = '#{host_name}' and log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts), minute(log_ts)"
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    #$logger.debug(sanitized)
    result = {}
    HttpAccessEntry.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:#{row.the_minute}")
      result[timestamp] = row
    end
    result
  end
  
  def HttpAccessEntryTable.group_host_stats_by_hour(host_name, starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour " +
    "FROM access_by_service_per_mins " +
    "where host_name = '#{host_name}' and log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts)"
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    #$logger.debug(sanitized)
    result = {}
    HttpAccessEntry.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:00")
      result[timestamp] = row
    end
    result
  end
  
  def HttpAccessEntryTable.group_host_stats_by_day(host_name, starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    
    statement = 
      "select " + grouped_data_columns + " " +
      "from access_by_service_per_hours " +
      "where host_name = '#{host_name}' and log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' "
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    #$logger.debug(sanitized)
    
    AccessByHostPerHour.find_by_sql(sanitized)
  end
  
  def HttpAccessEntryTable.group_totals_by_minute(starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour, minute(log_ts) the_minute " +
    "FROM access_by_host_per_mins " +
    "where log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts), minute(log_ts)"
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    #$logger.debug(sanitized)
    result = {}
    HttpAccessEntry.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:#{row.the_minute}")
      result[timestamp] = row
    end
    result
  end
  
  def HttpAccessEntryTable.group_totals_by_hour(starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour " +
    "FROM access_by_host_per_hours " +
    "where log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts)"
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    #$logger.debug(sanitized)
    result = {}
    HttpAccessEntry.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:00")
      result[timestamp] = row
    end
    result
  end
  
  def HttpAccessEntryTable.group_totals_by_day(starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    
    statement = 
      "select " + grouped_data_columns + " " +
      "from access_by_host_per_hours " +
      "where log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' "
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    #$logger.debug(sanitized)
    
    AccessByHostPerHour.find_by_sql(sanitized)
  end
  
  def HttpAccessEntryTable.find_old_slabs
    the_border = Time.now().to_i - (24 * 60 * 60) * DAYS_TO_KEEP
    date_string = Time.at(the_border).strftime("%Y%m%d")
    statement = "SELECT * FROM http_access_entry_tables WHERE the_day < '#{date_string}' AND is_archived = 0"
    sanitized = HttpAccessEntryTable.sanitize_sql(statement)
    HttpAccessEntryTable.find_by_sql(sanitized)
  end
  
  def archive_file_name
    [ RAW_DATA_ARCHIVE_DIR, host_name, service_name, the_day + ".tsv" ].join("/")
  end
  
  def create_table
    $logger.info "creating table #{table_name}"
    ActiveRecord::Base.connection.execute(        
      sprintf(CREATE_STATEMENT, table_name)
    )
  end
  
  def move_into_archive
    outfile_name = archive_file_name
    
    target_dir = File.dirname(outfile_name)
    FileUtils.mkdir_p(target_dir)
    File.chmod(0777, target_dir)
    
    select_outfile_command = "SELECT log_ts, host_name, service_name, method_name, remote_ip, x_forwarded_for, source_ip, http_host_name, http_method, http_version, return_code, response_size_bytes, response_time_microsecs, user_agent, referrer, md5_checksum, query_string " +
      "FROM #{table_name} " +
      "INTO OUTFILE '#{outfile_name}'"
    ActiveRecord::Base.connection.execute(select_outfile_command)        
    
    # convert into tarball
    tarball_name = outfile_name + ".tgz"
    outfile_filename = File.split(outfile_name).last
    `cd #{target_dir} && tar -czf #{tarball_name} #{outfile_filename}`
    File.delete(outfile_name)
    
    # remove the table from the database
    drop_command = "DROP TABLE #{table_name}"
    ActiveRecord::Base.connection.execute(drop_command)
    
    # set is_archived flag
    self.is_archived = true
    self.save()
  end
  
  # deletes the input file afterwards
  def restore_from_archive(file_name = nil)
    file_name = archive_file_name if file_name == nil
    target_dir = File.dirname(file_name)
    
    tarball_name = file_name + ".tgz"
    if File.exists?(tarball_name)
      `cd #{target_dir} && tar -xzf #{tarball_name}`
    end
    
    self.create_table()
    
    ActiveRecord::Base.connection.execute(
      "LOAD DATA LOCAL INFILE '#{file_name}' INTO TABLE #{table_name} " +
      "(log_ts, host_name, service_name, method_name, remote_ip, x_forwarded_for, source_ip, http_host_name, http_method, http_version, return_code, response_size_bytes, response_time_microsecs, user_agent, referrer, md5_checksum, query_string);"
    )
    
    File.delete(file_name)
    if File.exists?(tarball_name)
      File.delete(tarball_name)
    end
    
    # update is_archived flag
    self.is_archived = false
    self.save()
  end
  
end
