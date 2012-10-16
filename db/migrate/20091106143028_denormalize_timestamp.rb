class DenormalizeTimestamp < ActiveRecord::Migration

  @@columns = [:the_year, :the_month, :the_week, :the_day, :the_hour, :the_minute, :the_second]

  def self.up
#    change_table :http_access_entries do |t|
#      @@columns.each do |column_name|
#        t.column column_name, :integer
#      end
#    end
#    @@columns.each do |column_name|
#      pure_name = column_name.split('_')[1]
#      execute "update http_access_entries set #{column_name} = #{pure_name}(log_ts)"
#    end
  end

  def self.down
#    change_table :http_access_entries do |t|
#      @@columns.each do |column_name|
#        t.remove_column column_name
#      end
#    end
  end
end
