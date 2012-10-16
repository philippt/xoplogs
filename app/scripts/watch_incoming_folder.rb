(incoming_folder, archive_folder) = ARGV
unless incoming_folder
  puts "Usage: #{__FILE__} /path/to/incoming_folder [/path/to/processed_folder]"
  Kernel.exit(1)
end

require 'rubygems'
require 'logger'
#$logger = Logger.new("autoimport.log")

puts "starting to watch #{incoming_folder}"
if archive_folder != nil
  puts "gonna move processed files to #{archive_folder}"
end

while (2 > 1) do
  all_files = []
  Dir.new(incoming_folder).each do |file|
    all_files << file
  end
  all_files.sort.reverse.each do |file|
    
    full_filename = File.join(incoming_folder, file)
    
    `sudo chown www-data:ubuntu #{full_filename}`
    `sudo chmod g+rw #{full_filename}`
    
    next if /^\./.match(file) # ignore temporary files
    
    # xop_apache_i-fcd8c88b_fundeal.ro_access.log
    matched = /^(.+)_(.+)_(.+)_(.+)$/.match(file)
    if matched
      puts "matched : #{matched.captures.join("|")}"
      (parser, host_name, service_name, rest) = matched.captures
      
      # adjust host and service name
      host_name.gsub!("-", "_")
      host_name.gsub!(".", "_")
      service_name.gsub!("-", "_")
      service_name.gsub!(".", "_")
      
      puts "importing file '#{file}' for #{service_name}@#{host_name} with parser '#{parser}'"
      
      # import
      importer = AccessLogImporter.new(host_name, service_name, parser)
      begin
        imported_file = importer.process_file(full_filename)
        
        # and archive
        if archive_folder != nil
          archive_filename = imported_file.id.to_s + file
          full_archive_name = File.join(archive_folder, archive_filename)
          FileUtils.mv(full_filename, full_archive_name)
        
          # convert into tarball
          tar_file_name = archive_filename + '.tgz'
          command = "cd #{archive_folder} && tar -czf #{tar_file_name} #{archive_filename}"
          `#{command}`
          
          FileUtils.rm(full_archive_name)
        else
          FileUtils.rm(full_filename)
        end
      rescue AlreadyImportedError => e
        # this file has already been imported, no sense in archiving it
        FileUtils.rm(full_filename)
      end
    end
  end
  
  $logger.info "no more files found for import, sleeping"
  sleep 60
end