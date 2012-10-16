class AddTimestampToImportedFiles < ActiveRecord::Migration
  def self.up
    change_table :imported_files do |t|
      t.datetime :first_ts
      t.datetime :last_ts
    end
  end

  def self.down
  end
end
