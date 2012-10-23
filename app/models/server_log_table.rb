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

  def table_name
    'sl_' + self.host_name.gsub(/[\.-]/, "_") + '_' + self.service_name + '_' + self.the_day
  end
  
  def self.import_column_list
    %w|log_ts host_name service_name| +
    %w|log_level class_name message stacktrace|
  end
  
  def self.import_columns
    self.import_column_list.join(',')
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
  
  def create_table
    $logger.info "creating table #{table_name}"
    ActiveRecord::Base.connection.execute(        
      sprintf(CREATE_STATEMENT, table_name)
    )
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
      #"LOAD DATA LOCAL INFILE '#{file_name}' INTO TABLE #{table_name} " +
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
