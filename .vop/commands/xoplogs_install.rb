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
    machine.ssh_and_check_result("command" => "cd #{params["service_root"]} && #{command}")
  end
end
