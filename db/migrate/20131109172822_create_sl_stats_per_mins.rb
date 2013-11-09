class CreateSlStatsPerMins < ActiveRecord::Migration
  def change
    create_table :sl_stats_per_mins do |t|

      t.timestamps
    end
  end
end
