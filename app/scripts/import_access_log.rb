(file_name, file_type, host_name, service_name) = ARGV
unless file_name and file_type and host_name and service_name
  # TODO refactor ParserBase to use new parsers in helpers/parsers
  #known_parsers = ParserBase.known_parsers.join('|')
  known_parsers = %w|apache xop_apache nginx|
  puts "Usage: #{__FILE__} /path/to/log/file <#{known_parsers}.join('|')> <host_name> <service_name>"
  Kernel.exit(1)
end


require 'rubygems'
require 'logger'
$logger = Logger.new("import.log")

begin
  importer = AccessLogImporter.new(host_name, service_name, file_type)
  importer.process_file(file_name)
rescue AlreadyImportedError => e
  $logger.warn("duplicate file : #{e.message}")
end
