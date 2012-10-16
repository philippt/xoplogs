class PopulateDenormalizedTimestamp < ActiveRecord::Migration
  def self.up
    @@columns = [:the_year, :the_month, :the_week, :the_day, :the_hour, :the_minute, :the_second]

#    @@columns.each do |column_name|
#      pure_name = column_name.to_s.split('_')[1]
#      execute "update http_access_entries set #{column_name} = #{pure_name}(log_ts)"
#    end
  end

  def self.down
  end
end
