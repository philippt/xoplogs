class CreateHttpAccessEntries < ActiveRecord::Migration
  def self.up
    create_table :http_access_entries do |t|
      t.column :log_ts, :timestamp
      t.column :host_name, :string, :limit => 200
      t.column :service_name, :string, :limit => 200
      # for http access logs, URL and query string make up the method_name
      t.column :method_name, :string, :limit => 200
      t.column :remote_ip, :string, :limit => 20
      t.column :x_forwarded_for, :string, :limit => 100
      t.column :source_ip, :string, :limit => 20
      t.column :http_host_name, :string, :limit => 200
      t.column :http_method, :string, :limit => 10
      t.column :http_version, :string, :limit => 10
      t.column :return_code, :integer
      t.column :response_size_bytes, :integer
      t.column :response_time_microsecs, :integer
      t.column :user_agent, :string, :limit => 200
      t.column :referrer, :string, :limit => 200
      t.column :md5_checksum, :string, :limit => 100
      
      t.timestamps
    end
  end

  def self.down
    drop_table :http_access_entries
  end
end
