class CreateHttpAccessEntryTables < ActiveRecord::Migration
  def self.up
    create_table :http_access_entry_tables do |t|
      t.column :host_name, :string, :limit => 200
      t.column :service_name, :string, :limit => 200      
      t.column :the_day, :string, :limit => 10
      t.column :needs_aggregation, :boolean
      t.column :active_aggregator_pid, :integer
      t.column :last_aggregated_at, :timestamp

      t.timestamps
    end
  end

  def self.down
    drop_table :http_access_entry_tables
  end
end
