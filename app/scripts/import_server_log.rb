(file_name, file_type, host_name, service_name, options_string) = ARGV
unless file_name and file_type and host_name and service_name
  known_parsers = %w|jboss log4j ruby_logger|
  puts "Usage: #{__FILE__} /path/to/log/file <#{known_parsers.join('|')}> <host_name> <service_name> [options]"
  Kernel.exit(1)
end

require 'rubygems'
require 'logger'
$logger = Logger.new("log/import_server_log.log")

begin
  options = {}
  if options_string != nil and options_string != ''
    options_string.split(" ").each do |option_string|
      (k,v) = option_string.split("=")
      options[k.to_sym] = v
    end
  end
  importer = ServerLogImporter.new(host_name, service_name, file_type, options)
  importer.process_file(file_name)
rescue AlreadyImportedError => e
  $logger.warn("duplicate file : #{e.message}")
end
