class CreateSlStatsByHostPerMins < ActiveRecord::Migration
  def change
    create_table :sl_stats_by_host_per_mins do |t|

      t.timestamps
    end
  end
end
