class LookupIndexes < ActiveRecord::Migration
  def self.up
    [:host_name, :service_name, :http_host_name].each do |column_name|
      add_index :http_access_entries, column_name
    end
  end

  def self.down
  end
end
