class RawController < ApplicationController
  
  def index
    @slabs = HttpAccessEntryTable.find(
      :all,
      :conditions => [
        "host_name = ?",
        params[:host_name]
      ],
      :order => "the_day desc"
    ).map do |x|
      x["type"] = 'access' 
      x
    end
    
    @slabs += ServerLogTable.find(
      :all,
      :conditions => [
        "host_name = ?",
        params[:host_name]
      ],
      :order => "the_day desc"
    ).map do |x|
      x["type"] = 'server_log' 
      x
    end
  end
  
  def slab
    @prefix = /([^_]+)_/.match(params[:table_name]).captures.first
    @raw = case @prefix
    when 'sl'
      ServerLogTable.raw_data(params[:table_name])
    when 'hae' 
      HttpAccessEntryTable.raw_data(params[:table_name])   
    end
  end
  
end
