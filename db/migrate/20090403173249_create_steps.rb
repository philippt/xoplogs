class CreateSteps < ActiveRecord::Migration
  def self.up
    create_table :steps do |t|
      t.column :flow_id, :integer, :limit => 200
      t.column :idx, :integer, :limit => 200
      t.column :service_name, :string, :limit => 200
      t.column :method_name, :string, :limit => 200
      t.timestamps
    end
  end

  def self.down
    drop_table :steps
  end
end
