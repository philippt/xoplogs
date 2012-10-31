class ImporterBase

  def initialize(host_name, service_name, file_type)
    @host_name = host_name
    @service_name = service_name
    @file_type = file_type
    
    @known_parsers = {}
  end
  
  def parser
    if @known_parsers.has_key?(@file_type)
      parser = @known_parsers[@file_type].new(@host_name, @service_name)
    else
      raise "unknown file type #{@file_type}"
    end
  end
  
  def prepare_import(file_name)
    $logger.debug "reading from file #{file_name} for #{@service_name}@#{@host_name}"
    
    # check by md5sum if this file has been imported already
    md5sum_file = `md5sum #{file_name} | cut -d " " -f1`.strip    

    already_imported = ImportedFile.find_by_md5sum(md5sum_file)
    if already_imported
      $logger.warn "already imported this file - md5sum check matched (#{md5sum_file})"
      raise AlreadyImportedError.new("already imported this file - md5sum check matched (#{md5sum_file})")
    end
    
    # find the last position until which we imported log files
    last_imported_file = ImportedFile.find(
      :first, 
      :conditions => [ "host_name = ? and service_name = ?", @host_name, @service_name ],
      :order => 'last_ts desc'
    )    
    last_imported_position = last_imported_file == nil ? 0 : last_imported_file.last_ts.to_i
    
    # and initialize the database entry for this imported file
    @imported_file = ImportedFile.new()
    @imported_file.host_name = @host_name
    @imported_file.service_name = @service_name
    @imported_file.file_name = file_name
    @imported_file.md5sum = md5sum_file
    @imported_file.lines_total = `wc -l #{file_name}`.strip 
    @imported_file.processing_duration = 0
    @imported_file.import_duration = 0
    @imported_file.save()   

    # parse the file and convert into tab-separated values
    @file_name = file_name
    
    @unparseable_count = 0
    @read_count = 0
    @ignored_old_count = 0
    @processed_count = 0
    
    @parsed_entries = {}
    
    last_imported_position
  end
    
  def process_file(file_name)
    last_imported_position = prepare_import(file_name)
    
    first_entry = nil
    last_entry = nil      
    
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
          # this entry could be parsed successfully
          # now, should we import it?
          # TODO we're losing some entries here in the overlapping second 
          if entry[:log_ts].to_i <= last_imported_position
            @ignored_old_count += 1
            next              
          end
          
          the_day = entry[:log_ts].strftime("%Y%m%d")
          
          if entry.class.to_s == "Hash"
            # and write tab-separatedly into the outfile
            puts "got entry hash from line #{idx}"
            the_values = []
            @model_class.import_column_list.each do |column|
              the_values << entry[column.to_sym]
            end
            
            the_values[0] = entry[:log_ts].strftime("%Y-%m-%d %H:%M:%S")
            
            @parsed_entries[the_day] = [] unless @parsed_entries.has_key?(the_day)
            @parsed_entries[the_day] << the_values
            
            # keep track of which records we imported
            first_entry = entry if first_entry == nil
            last_entry = entry
          else
            puts "adding stacktrace from line #{idx}"
            @parsed_entries[the_day].last[:stacktrace] += "\n#{entry}"
          end
          
          @read_count += 1
        else
          $logger.debug "[UNPARSEABLE] #{line}"
          @unparseable_count += 1
        end
        
        idx += 1          
      end
    end

    import_parsed_entries
       
    @imported_file.first_ts = first_entry[:log_ts] if first_entry != nil
    @imported_file.last_ts = last_entry[:log_ts] if last_entry != nil
    
    write_stats
    
    @imported_file
  end
  
  def import_parsed_entries
    @parsed_entries.each do |the_day, entries|
      tsv_file_name = @file_name + '_' + the_day + '.tsv'
      import_file the_day, tsv_file_name
    end
  end
  
  def import_file(the_day, file_name)
    $logger.info "writing batch of #{@parsed_entries[the_day].size} parsed entries to file"
    File.open(file_name, "w") do |outfile|
      @parsed_entries[the_day].each do |entry|
        outfile << entry.join("\t")
        outfile << "\n"  
      end
    end        
    
    target_table = @model_class.find(
      :first,
      :conditions => [
        "host_name = ? AND service_name = ? AND the_day = ?",
        @host_name,
        @service_name,
        the_day
      ]
    )
    if target_table == nil        
      target_table = @model_class.new()
      target_table.host_name = @host_name
      target_table.service_name = @service_name
      target_table.the_day = the_day
      
      target_table.create_table()
            
      #target_table.last_aggregated_id = 0
      target_table.save
    end
    
    if target_table.is_archived
      target_table.restore_from_archive
    end
    
    # and load the tsv file
    import_start = Time.now()
    target_table.restore_from_archive file_name
    import_stop = Time.now()
    @imported_file.import_duration += import_stop - import_start
    
    target_table.needs_aggregation = 1
    target_table.save
    
    @parsed_entries[the_day] = []
  end
  
  def write_stats()
    @imported_file.lines_processed = @processed_count
    @imported_file.lines_read = @read_count    
    @imported_file.lines_unparseable = @unparseable_count
    @imported_file.lines_ignored_old = @ignored_old_count
    
    @imported_file.save()
  end
  
end