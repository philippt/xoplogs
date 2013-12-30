#require 'pp'

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

  def upload
    
  end
  
  def upload_file
    file_name = params[:pic].tempfile.to_path.to_s
    
    host_name, service_name, file_type = params[:host_name], params[:service_name], params[:parser]
        
    begin
      importer = AccessLogImporter.new(host_name, service_name, file_type)
      importer.process_file(file_name)
    rescue AlreadyImportedError => e
      $logger.warn("duplicate file : #{e.message}")
    end
    
  end

  def parse_data
    the_model = (params[:type] && params[:type] == 'server_log') ? ServerLogImporter : AccessLogImporter
    $logger.debug "model : #{the_model}"
    parser = the_model.new('no.such.host', 'dummy', params[:parser]).parser
    $logger.debug "parser : #{parser}"
    
    entries = []
    if params[:pic] and params[:pic].respond_to?(:tempfile)
      file_name = params[:pic].tempfile.to_path.to_s
      
      File.open(file_name, "r") do |infile|
        while (line = infile.gets)
          entries << parser.parse(line)
        end
      end
    elsif params[:lines]
      count = 0
      params[:lines].each do |line|
        count += 1
        parsed = parser.parse(line)
        if parsed
          entries << parsed
        else
          if count < 5
            $logger.warn "could not parse with #{params[:parser]}: #{line}"
          end
        end
      end 
    end
    
    puts "parsed #{entries.size} entries with #{params[:parser]}"
    
    entries
  end
  
  def parse
    render :json => parse_data
  end
  
  def point_or_null(line, ts)
    point = line.select { |x| x[0] == ts }.first
    if point
      puts "found #{Time.at(point[0])}"
      point
    else
      puts "nilling for #{Time.at(ts)}"
      [ ts, 0 ]
    end
  end

  def parse_and_aggregate
    entries = parse_data
    
    buckets = PartitionedAggregator.aggregate(entries, params[:type], params[:interval])

    if params[:interval]
      puts "interval : #{params[:interval]}"
      now = Time.now
      count = params[:count] ? params[:count].to_i : 1
      case params[:interval].to_sym
      when :minute
        start = now.to_i
	buckets.each do |selector, line|
          new_data = []

          0.upto(59 * count) do |offset|
            ts = start - offset
            new_data << point_or_null(line, ts)
          end

          buckets[selector] = new_data
        end        
        
      when :hour
        start = now.to_i - now.sec

        buckets.each do |selector, line|
          new_data = []
	  0.upto(59 * count) do |offset|
	    ts = start - offset * 60
            new_data << point_or_null(line, ts)
	  end
          buckets[selector] = new_data
        end
 
      when :day
        start = now.to_i - now.sec - now.min * 60

        buckets.each do |selector, line|
          new_data = []
          0.upto(23 * count) do |offset|
            ts = start - offset * 60 * 60
            new_data << point_or_null(line, ts)
          end
          buckets[selector] = new_data
        end
      when :week
        start = now.to_i - now.sec - now.min * 60 - now.hour * 60 * 60

        buckets.each do |selector, line|
          new_data = []
          
          0.upto(6 * count)  do |offset|
            ts = start - offset * 60 * 60 * 24
            new_data << point_or_null(line, ts)
          end

          buckets[selector] = new_data
        end
      else
        # no interval?
      end
    end

    buckets.each do |selector, e|
      e.each do |entry|
        entry[0] = entry[0] * 1000
      end
    end
    
    json = {
      'stats' => buckets,
      'parsed' => entries
    }
    render :json => json.to_json()
  end
  
end
