description "installation script for xoplogs"

param :machine
param! "domain", "the domain at which the service should be available"
param! "service_root"

on_machine do |machine, params|
  begin
    # TODO same code as in my_sql_install - this version works, though (cause by now the service has been started.)
    new_password = 'the_password'
    machine.ssh_and_check_result("command" => "mysqladmin -u root password #{new_password}")
  rescue
  end
  
  [
    'bundle install',
    'rake db:create',
    'rake db:migrate' 
  ].each do |command|
    machine.ssh_and_check_result("command" => "cd #{params["service_root"]} && #{command}")
  end
  
  machine.install_service_from_working_copy("working_copy" => "xoplogs", "service" => "aggregator")
  machine.install_service_from_working_copy("working_copy" => "xoplogs", "service" => "total_aggregator")
end
