require 'parsers/jboss_server_log'
require 'pp'

class ServerLogImporter < ImporterBase
  
  def initialize(host_name, service_name, file_type)
    super(host_name, service_name, file_type)
    
    @known_parsers.merge!({
      "jboss" => JbossServerLog
    })
    
    @model_class = ServerLogTable
  end
  
  def process_file(file_name)
    last_imported_position = prepare_import(file_name)
    
    first_entry = nil
    last_entry = nil
    
    stacktraces = {}      
    
    puts "importing #{file_name} - interesting columns for parser #{parser.class.to_s} are #{@model_class.import_columns}"
    
    idx = 0
    File.open(file_name, "r") do |infile|
      while (line = infile.gets)
        if @read_count % 50000 == 0
          import_parsed_entries
        end
        
        parsing_start = Time.now()
        entry = parser.parse(line)
        puts "#{idx} #{entry}"
        parsing_stop = Time.now()
        @imported_file.processing_duration += parsing_stop.to_i - parsing_start.to_i

        @processed_count += 1
        # write the stats into the database once in a while
        if @processed_count % 1000 == 0
          write_stats
        end
        
        if entry != nil          
          # TODO we're losing some entries here in the overlapping second 
          if entry[:log_ts].to_i <= last_imported_position
            @ignored_old_count += 1
            next              
          end
          
          the_day = entry[:log_ts].strftime("%Y%m%d")
          
          @parsed_entries[the_day] = [] unless @parsed_entries.has_key?(the_day)
          @parsed_entries[the_day] << entry
          
          first_entry = entry if first_entry == nil
          last_entry = entry
          
          @read_count += 1
        else
          line.chomp!.strip!          
          last_entry[:stacktrace] += "|#{line}"
          
          # TODO improve error handling
          #$logger.debug "[UNPARSEABLE] #{line}"
          #@unparseable_count += 1
        end
        
        idx += 1          
      end
    end
    
    @parsed_entries.each do |the_day, entries|
      entries.map! do |entry|
        the_values = []
        @model_class.import_column_list.each do |column|
          the_values << entry[column.to_sym]
        end
        the_values[0] = entry[:log_ts].strftime("%Y-%m-%d %H:%M:%S")
        the_values
      end
    end
    
    import_parsed_entries
       
    @imported_file.first_ts = first_entry[:log_ts] if first_entry != nil
    @imported_file.last_ts = last_entry[:log_ts] if last_entry != nil
    
    write_stats
    
    @imported_file
  end
  
end