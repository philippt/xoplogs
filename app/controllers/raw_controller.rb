class RawController < ApplicationController
  
  def index
    @slabs = HttpAccessEntryTable.find(
      :all,
      :conditions => [
        "host_name = ?",
        params[:host_name]
      ],
      :order => "the_day desc"
    )
  end
  
end
