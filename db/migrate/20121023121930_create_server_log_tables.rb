class CreateServerLogTables < ActiveRecord::Migration
  def change
    create_table :server_log_tables do |t|
      t.column :host_name, :string, :limit => 200
      t.column :service_name, :string, :limit => 200      
      t.column :the_day, :string, :limit => 10
      
      t.column :needs_aggregation, :boolean
      t.column :active_aggregator_pid, :integer
      t.column :last_aggregated_at, :timestamp
      t.column :is_archived, :boolean, :default => false

      t.timestamps
    end
  end
end
