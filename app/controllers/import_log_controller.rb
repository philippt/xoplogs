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
  
  def test
    file = ImportedFile.find(params[:id])
    @batch = `head -n5000 #{file.file_name}`
    
    #TODO parser = ServerLogImporter.new('no.such.host', 'dummy', params[:parser]).parser
    parser = AccessLogImporter.new('no.such.host', 'dummy', params[:parser]).parser
    
    idx = 0
    @parsed = {}
    @batch.split("\n").each do |line|
      @parsed[idx] = parser.parse(line)
      idx += 1
    end 
  end
  
end
