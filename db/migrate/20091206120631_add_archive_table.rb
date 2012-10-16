class AddArchiveTable < ActiveRecord::Migration
  def self.up
    execute "create table http_access_entries_archive as select * from http_access_entries where id = 0"
  end

  def self.down
    drop_table :http_access_entries_archive
  end
end
