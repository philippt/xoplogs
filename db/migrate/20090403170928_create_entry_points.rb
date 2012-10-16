class CreateEntryPoints < ActiveRecord::Migration
  def self.up
    create_table :entry_points do |t|
      t.column :service_name, :string, :limit => 200
      t.column :method_name, :string, :limit => 200
      t.timestamps
    end
  end

  def self.down
    drop_table :entry_points
  end
end
