class CreateSlStatsPerHours < ActiveRecord::Migration
  def change
    create_table :sl_stats_per_hours do |t|

      t.timestamps
    end
  end
end
