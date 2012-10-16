class AddAggregatedFlagToArchive < ActiveRecord::Migration
  def self.up
    change_table :http_access_entries_archive do |t|
      t.column :aggregated_flag, :integer
    end
  end

  def self.down
  end
end
