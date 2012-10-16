class AddIsArchivedFlagToHttpAccessEntryTables < ActiveRecord::Migration
  def self.up
    change_table :http_access_entry_tables do |t|
      t.column :is_archived, :boolean, :default => false
    end
  end

  def self.down
  end
end
