class CreateImportedFiles < ActiveRecord::Migration
  def self.up
    create_table :imported_files do |t|
      t.column :host_name, :string, :limit => 200
      t.column :service_name, :string, :limit => 200
      t.column :file_name, :string, :limit => 200
      t.column :md5sum, :string, :limit => 200
      #t.column :import_start, :timestamp
      #t.column :import_stop, :timestamp
      #t.column :lines, :integer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :imported_files
  end
end
