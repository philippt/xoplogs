class AddDurationToImportFiles < ActiveRecord::Migration
  def self.up
    change_table :imported_files do |t|
      t.column :processing_duration, :integer
      t.column :import_duration, :integer
    end
  end

  def self.down
  end
end
