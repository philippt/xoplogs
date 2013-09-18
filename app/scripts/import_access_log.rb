(file_name, file_type, host_name, service_name, options_string) = ARGV
unless file_name and file_type and host_name and service_name
  # TODO refactor ParserBase to use new parsers in helpers/parsers
  #known_parsers = ParserBase.known_parsers.join('|')
  known_parsers = %w|apache apache_ssl_combined xop_apache nginx squid|
  puts "Usage: #{__FILE__} /path/to/log/file <#{known_parsers.join('|')}> <host_name> <service_name> [options]"
  Kernel.exit(1)
end


require 'rubygems'
require 'logger'
$logger = Logger.new("import.log")

begin
  options = {}
  if options_string != nil and options_string != ''
    options_string.split(" ").each do |option_string|
      (k,v) = option_string.split("=")
      options[k] = v
    end
  end
  importer = AccessLogImporter.new(host_name, service_name, file_type, options)
  importer.process_file(file_name)
rescue AlreadyImportedError => e
  $logger.warn("duplicate file : #{e.message}")
end
