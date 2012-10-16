class CreateFlows < ActiveRecord::Migration
  def self.up
    create_table :flows do |t|
      t.column :entry_point_id, :integer, :limit => 200
      t.column :idx, :integer, :limit => 200
      t.column :name, :string, :limit => 200
      t.timestamps
    end

    # TODO can we add foreign key relations here?
    # TODO add an UNIQUE index over entry_point_id, idx
  end

  def self.down
    drop_table :flows
  end
end
