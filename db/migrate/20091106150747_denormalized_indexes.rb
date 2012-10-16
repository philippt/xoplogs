class DenormalizedIndexes < ActiveRecord::Migration
  def self.up
    #add_index :http_access_entries, [:the_year, :the_month, :the_week, :the_day, :the_hour, :the_minute, :the_second], :name => 'idx_denormalized_ts'
  end

  def self.down
  end
end
