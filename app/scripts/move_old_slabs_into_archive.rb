HttpAccessEntryTable.find_old_slabs.each do |old_slab|
  old_slab.move_into_archive
end