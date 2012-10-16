class AddIndex < ActiveRecord::Migration
  def self.up
    add_index :http_access_entries, :log_ts
  end

  def self.down
    remove_index :http_access_entries, :log_ts
  end
end
