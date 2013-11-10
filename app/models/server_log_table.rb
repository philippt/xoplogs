require 'pp'

class ServerLogTable < ActiveRecord::Base
  # attr_accessible :title, :body
  
    CREATE_STATEMENT = <<EOF
CREATE TABLE IF NOT EXISTS %s (
  id int(11) NOT NULL auto_increment,
  log_ts datetime default NULL,
  host_name varchar(200) default NULL,
  service_name varchar(200) default NULL,
  
  log_level varchar(10) default NULL,
  class_name varchar(200) default NULL,
  message varchar(200) default NULL,
  stacktrace text default NULL,
    
  created_at datetime default NULL,
  updated_at datetime default NULL,
  
  
  PRIMARY KEY  (id),
    
  KEY index_http_access_entries_on_log_ts (log_ts),
  KEY index_http_access_entries_on_host_name (host_name),
  KEY index_http_access_entries_on_service_name (service_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

EOF

  def self.mysql_loader_dir
    $app_config['mysql_loader_dir'] || "/var/lib/mysql_import/"
  end 

  def table_name
    'sl_' + self.host_name.gsub(/[\.-]/, "_") + '_' + self.service_name + '_' + self.the_day
  end
  
  def self.raw_data(table_name)
    statement = "select * from #{table_name} limit 100"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    self.find_by_sql(sanitized)
  end
  
  def start_ts
    Time.parse(the_day)
  end
  
  def stop_ts
    Time.at(Time.parse(the_day).to_i + 24 * 60 * 60)
  end
  
  def self.import_column_list
    %w|log_ts host_name service_name| +
    %w|log_level class_name message stacktrace|
  end
  
  def self.import_columns
    self.import_column_list.join(',')
  end
  
  def self.grouped_data_columns
    "sum(debug_count) debug_sum, sum(info_count) info_sum, sum(warn_count) warn_sum, sum(error_count) error_sum"
  end
  
  def self.table_exists(table_name)
    statement = "show tables like '#{table_name}'"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    self.find_by_sql(sanitized).size > 0
  end
  
  def self.find_all_hosts
    statement = "select distinct host_name from server_log_tables order by 1"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    self.find_by_sql(sanitized).collect do |row|
      row['host_name']
    end
  end
  
  def self.log_levels
    %w|debug info warn error|
  end
  
  def create_table
    $logger.info "creating table #{table_name}"
    ActiveRecord::Base.connection.execute(        
      sprintf(CREATE_STATEMENT, table_name)
    )
  end
  
  def standard_condition
    "host_name = '#{self.host_name}' and service_name = '#{self.service_name}' and log_ts >= '#{start_ts.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_ts.strftime("%Y-%m-%d %H:%M:%S")}'"
  end
  
  def self.find_table_for_aggregator    
    the_pid = Process.pid
    ActiveRecord::Base.connection.execute(
      "update server_log_tables set active_aggregator_pid = #{the_pid} where needs_aggregation = 1 and active_aggregator_pid is null limit 1"
    )    
    
    the_table = ServerLogTable.find(
      :first,
      :conditions => [
        "active_aggregator_pid = ? AND needs_aggregation = 1", 
        the_pid
      ]
    )
    
    the_table
  end
  
  def self.find_recently_upgraded_service_stat_slabs(newer_than_timestamp)
    statement = "select distinct host_name, the_day from server_log_tables where needs_aggregation = 0 and last_aggregated_at is not NULL and last_aggregated_at >= '#{newer_than_timestamp.strftime("%Y-%m-%d %H:%M:%S")}'"
    $logger.info "sanitized : #{statement}"
    sanitized = ActiveRecord::Base.sanitize_sql_array(statement)
    ServerLogTable.find_by_sql(sanitized)
  end
  
  
  
  
  def update_stats
    $logger.info "aggregating server log stats from #{self.table_name}..."
    
    by_service_per_mins
    by_service_per_hours
    stats = by_service_per_days
    
    s = stats.map do |level, count|
      "#{level} : #{count}"
    end.join(', ')
    $logger.info "updated stats for #{self.service_name}@#{self.host_name} : #{s} between #{start_ts} and #{stop_ts}"
  end
  
  # fill up gaps and write per-minute statistics
  def by_service_per_mins
    entries = group_by_level_and_minute
    
    minutes = []
    
    0.upto(23) do |hour|
      0.upto(59) do |minute|
        
        the_timestamp = Time.at(start_ts + (hour * 60 + minute) * 60)
        
        entry = entries[the_timestamp]
        
        row = [
          the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
          self.host_name,
          self.service_name
        ]
        
        ServerLogTable.log_levels.each do |log_level|
          count = (entry && entry.has_key?(log_level)) ? entry[log_level] : 0
          row << count 
        end
        
        minutes << row
      end
    end
    
    file_name = "#{ServerLogTable.mysql_loader_dir}/sl_stats_service_minutes"
    File.open(file_name, "w") do |outfile|
      minutes.each do |row|
        outfile << row.join("\t")
        outfile << "\n"  
      end
    end
    #system "sudo `which chown` mysql: #{file_name}"
    ActiveRecord::Base.connection.execute(
      # TODO "LOAD DATA LOCAL INFILE '#{file_name}' INTO TABLE #{table_name} " +
      "LOAD DATA INFILE '#{file_name}' REPLACE INTO TABLE sl_stats_by_service_per_mins " +
      "(log_ts,host_name,service_name,debug_count,info_count,warn_count,error_count);"
    )
    
    minutes
  end
  
  def by_service_per_hours
    grouped_by_hour = get_hour_stats_from_minutes
    
    hours = []
    
    0.upto(23) do |hour|
      the_timestamp = Time.at(start_ts + (hour * 60 * 60))
      
      row = [
        the_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
        self.host_name,
        self.service_name
      ]
      
      entry = grouped_by_hour[the_timestamp]
      
      ServerLogTable.log_levels.each do |log_level|
        count = (entry && entry.has_key?(log_level)) ? entry[log_level] : 0
        row << count 
      end
      hours << row
    end
    
    file_name = "#{ServerLogTable.mysql_loader_dir}/sl_stats_service_hours"
    File.open(file_name, "w") do |outfile|
      hours.each do |row|
        outfile << row.join("\t")
        outfile << "\n"  
      end
    end
    #system "sudo `which chown` mysql: #{file_name}"
    ActiveRecord::Base.connection.execute(
      "LOAD DATA INFILE '#{file_name}' REPLACE INTO TABLE sl_stats_by_service_per_hours " +
      "(log_ts,host_name,service_name,debug_count,info_count,warn_count,error_count);"
    )
  end
  
  def by_service_per_days
    stats = get_daily_stats_from_hours
   
    levels = stats.keys.sort
    
    count_columns = levels.map { |x| "#{x}_count" }.join(', ')
    count_values = levels.map { |x| "#{stats[x]}" }.join(', ')
    
    statement = "INSERT INTO sl_stats_by_service_per_days(log_ts, host_name, service_name, #{count_columns}) " +
             "VALUES('#{start_ts.strftime("%Y-%m-%d %H:%M:%S")}', '#{self.service_name}', '#{self.host_name}', #{count_values}) " +
             "ON DUPLICATE KEY UPDATE " +
             levels.map{ |x| "#{x}_count = VALUES(#{x}_count)" }.join(', ')
                 
    ActiveRecord::Base.connection.execute(statement)
    
    stats
  end




  def group_by_level_and_minute
    conditions = [ 
      "SELECT year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour, minute(log_ts) the_minute, log_level, count(1) the_count " + 
      "FROM #{table_name} " +
      "GROUP BY year(log_ts), month(log_ts), day(log_ts), hour(log_ts), minute(log_ts), log_level " +
      "ORDER BY log_ts"
    ]
    
    statement = conditions.first
    sanitized = ActiveRecord::Base.send(:sanitize_sql_array, statement)
    
    result = {}
    ServerLogTable.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:#{row.the_minute}")
      unless result.has_key?(timestamp)
        result[timestamp] = {}
      end
      level = row.log_level.downcase
      unless result[timestamp].has_key?(level)
        result[timestamp][level] = 0
      end
      result[timestamp][level] += row.the_count.to_i
    end
    result
  end
  
  def get_hour_stats_from_minutes
    statement = 
      "select " + ServerLogTable.grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour " +
      "from sl_stats_by_service_per_mins " +
      "where " + standard_condition + " " +
      "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts)"
      
    sanitized = ServerLogTable.send(:sanitize_sql_array, statement)
    
    result = {}
    
    ServerLogTable.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:00")
      
      unless result.has_key?(timestamp)
        result[timestamp] = {}
      end
      
      ServerLogTable.log_levels.each do |log_level|
        column_name = "#{log_level}_sum"
        result[timestamp][log_level] = row.send(column_name.to_sym).to_i
      end
    end
    result
  end
  
  def get_daily_stats_from_hours
    result = {}
    
    statement = 
      "select " + ServerLogTable.grouped_data_columns + ' ' +
      "from sl_stats_by_service_per_hours " +
      "where " + standard_condition
    sanitized = ServerLogTable.send(:sanitize_sql_array, statement)
    
    ServerLogTable.find_by_sql(sanitized).each do |row|
      ServerLogTable.log_levels.each do |log_level|
        column_name = "#{log_level}_sum"
        result[log_level] = row.send(column_name.to_sym).to_i
      end
    end
    
    result
  end
  
  def self.group_service_stats_by_host(host_name, starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + ServerLogTable.grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour, minute(log_ts) the_minute " +
    "FROM sl_stats_by_service_per_mins " +
    "where host_name = '#{host_name}' and log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts), minute(log_ts)"
    sanitized = ActiveRecord::Base.send(:sanitize_sql_array, statement)
    result = {}
    ServerLogTable.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:#{row.the_minute}")
      
      stats = {}
      ServerLogTable.log_levels.each do |log_level|
        column_name = "#{log_level}_sum"
        stats[log_level] = row.send(column_name.to_sym).to_i
      end
      result[timestamp] = stats
    end
    result
  end
  
  def self.group_host_stats_by_hour(host_name, starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour " +
    "FROM sl_stats_by_service_per_mins " +
    "where host_name = '#{host_name}' and log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts)"
    sanitized = ActiveRecord::Base.send(:sanitize_sql_array, statement)
    result = {}
    ServerLogTable.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:00")
      
      stats = {}
      ServerLogTable.log_levels.each do |log_level|
        column_name = "#{log_level}_sum"
        stats[log_level] = row.send(column_name.to_sym).to_i
      end
      result[timestamp] = stats
    end
    result
  end
  
  def self.group_host_stats_by_day(host_name, starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    
    statement = 
      "select " + grouped_data_columns + " " +
      "from sl_stats_by_host_per_hours " +
      "where host_name = '#{host_name}' and log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' "
    sanitized = ActiveRecord::Base.send(:sanitize_sql_array, statement)
    SlStatsByHostPerHour.find_by_sql(sanitized)
  end
  
  def self.level_hash(row)
    stats = {}
    log_levels.each do |log_level|
      column_name = "#{log_level}_sum"
      stats[log_level] = row.send(column_name.to_sym).to_i
    end
    stats
  end
  
  def self.group_totals_by_minute(starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour, minute(log_ts) the_minute " +
    "FROM sl_stats_by_host_per_mins " +
    "where log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts), minute(log_ts)"
    sanitized = ActiveRecord::Base.send(:sanitize_sql_array, statement)
    result = {}
    ServerLogTable.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:#{row.the_minute}")
      result[timestamp] = level_hash(row)
    end
    result
  end
  
  def self.group_totals_by_hour(starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    statement = 
    "SELECT " + grouped_data_columns + ", year(log_ts) the_year, month(log_ts) the_month, day(log_ts) the_day, hour(log_ts) the_hour " +
    "FROM sl_stats_by_host_per_hours " +
    "where log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' " +
    "group by year(log_ts), month(log_ts), day(log_ts), hour(log_ts)"
    sanitized = ActiveRecord::Base.send(:sanitize_sql_array, statement)
    result = {}
    ServerLogTable.find_by_sql(sanitized).each do |row|
      timestamp = Time.parse("#{row.the_year}-#{row.the_month}-#{row.the_day} #{row.the_hour}:00")
      result[timestamp] = level_hash(row)
    end
    result
  end
  
  def self.group_totals_by_day(starting_from_timestamp)
    stop_timestamp = starting_from_timestamp + 24 * 60 * 60
    
    statement = 
      "select " + grouped_data_columns + " " +
      "from sl_stats_per_hours " +
      "where log_ts >= '#{starting_from_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' and log_ts < '#{stop_timestamp.strftime("%Y-%m-%d %H:%M:%S")}' "
    sanitized = ActiveRecord::Base.send(:sanitize_sql_array, statement)
    SlStatsPerHour.find_by_sql(sanitized)
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
      # TODO "LOAD DATA LOCAL INFILE '#{file_name}' INTO TABLE #{table_name} " +
      "LOAD DATA INFILE '#{file_name}' INTO TABLE #{table_name} " +
      "(#{ServerLogTable.import_columns});"
    )
    
    #File.delete(file_name)
    if File.exists?(tarball_name)
      File.delete(tarball_name)
    end
    
    # update is_archived flag
    self.is_archived = false
    self.save()
  end
  
end
