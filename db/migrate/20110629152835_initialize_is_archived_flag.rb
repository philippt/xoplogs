class InitializeIsArchivedFlag < ActiveRecord::Migration
  def self.up
    HttpAccessEntryTable.find(:all).each do |slab|
      if not HttpAccessEntryTable.table_exists(slab.table_name)
        slab.is_archived = true
        slab.save()
      end
    end
  end

  def self.down
  end
end
