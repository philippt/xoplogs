class CreateSlStatsByServicePerDays < ActiveRecord::Migration
  def change
    create_table :sl_stats_by_service_per_days do |t|

      t.timestamps
    end
  end
end
