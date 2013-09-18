description "installation script for xoplogs"

param :machine
param! "domain", "the domain at which the service should be available"
param! "service_root"

on_machine do |machine, params|
 [
    'bundle install',
    'rake db:create',
    'rake db:migrate' 
  ].each do |command|
    machine.ssh("command" => "cd #{params["service_root"]} && #{command}")
  end
  
  machine.install_service_from_working_copy("working_copy" => "xoplogs", "service" => "aggregator")
  machine.install_service_from_working_copy("working_copy" => "xoplogs", "service" => "total_aggregator")
  
  machine.mkdir("dir_name" => "/var/lib/mysql_import")
  machine.chown("file_name" => "/var/lib/mysql_import", "ownership" => "mysql:")
end
