class AddStatsToImportedFiles < ActiveRecord::Migration
  def self.up
    change_table :imported_files do |t|
      t.column :lines_read, :integer
      t.column :lines_unparseable, :integer
      t.column :lines_ignored_old, :integer
      t.column :lines_processed, :integer
      t.column :lines_total, :integer
    end
  end

  def self.down
  end
end
