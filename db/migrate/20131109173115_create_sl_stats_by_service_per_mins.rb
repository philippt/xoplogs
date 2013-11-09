class CreateSlStatsByServicePerMins < ActiveRecord::Migration
  def change
    create_table :sl_stats_by_service_per_mins do |t|

      t.timestamps
    end
  end
end
