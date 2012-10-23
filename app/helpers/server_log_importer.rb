require 'parsers/jboss_server_log'

class ServerLogImporter < ImporterBase
  
  def initialize(host_name, service_name, file_type)
    super(host_name, service_name, file_type)
    
    @known_parsers.merge!({
      "jboss" => JbossServerLog
    })
    
    @model_class = ServerLogTable
  end
  
    
  
end