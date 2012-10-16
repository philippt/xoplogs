class CreateSqlStatements < ActiveRecord::Migration
  def self.up
    create_table :sql_statements do |t|
      t.column :statement, :string, :limit => 4000
      t.timestamps
    end
  end

  def self.down
    drop_table :sql_statements
  end
end
