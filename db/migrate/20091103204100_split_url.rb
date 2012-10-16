class SplitUrl < ActiveRecord::Migration
  def self.up
    change_table :http_access_entries do |t|
      t.column :query_string, :string, :limit => 1024
    end
    execute "update http_access_entries set query_string = if(locate('?', method_name) > 0, substr(method_name, locate('?', method_name)+1), null)"
    execute "update http_access_entries set method_name = if(locate('?', method_name) > 0, substr(method_name, 1, locate('?', method_name)-1), method_name)"
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
