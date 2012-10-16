class AddAggregatedFlag < ActiveRecord::Migration
  def self.up
    change_table :http_access_entries do |t|
      t.column :aggregated_flag, :integer
    end
  end

  def self.down
    change_table :http_access_entries do |t|
      t.remove_column :aggregated_flag
    end
  end
end
