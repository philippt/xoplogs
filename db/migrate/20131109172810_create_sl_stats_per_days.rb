class CreateSlStatsPerDays < ActiveRecord::Migration
  def change
    create_table :sl_stats_per_days do |t|

      t.timestamps
    end
  end
end
