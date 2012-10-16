class CreateAggregatorStatuses < ActiveRecord::Migration
  def self.up
    create_table :aggregator_statuses do |t|
      t.integer :last_aggregated_id

      t.timestamps
    end
  end

  def self.down
    drop_table :aggregator_statuses
  end
end
