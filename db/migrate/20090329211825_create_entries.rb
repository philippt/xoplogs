class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.column :log_ts, :timestamp
      t.column :request_id, :string, :limit => 200
      t.column :service_name, :string, :limit => 200
      t.column :method_name, :string, :limit => 200
      t.column :arguments, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
