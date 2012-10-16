class ImportLogController < ApplicationController
  
  def index
    if params.has_key?("host_name") and params["host_name"] != nil and params["host_name"] != ""
      @files = ImportedFile.find(
        :all,
        :conditions => [
          "host_name = ?", 
          params["host_name"]      
        ],
        :order => "created_at desc",
        :limit => 50
      )
    else
      @files = ImportedFile.find(
        :all,
        :order => "created_at desc",
        :limit => 50
      )
    end
  end
  
end
