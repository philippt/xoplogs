class AddAggregatedUpToTimestampToAggregatorStatus < ActiveRecord::Migration
  def self.up
    change_table :aggregator_statuses do |t|
      t.column :aggregated_up_to, :timestamp
    end
  end

  def self.down
  end
end
