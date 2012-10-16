#$logger = RAILS_DEFAULT_LOGGER
#$logger = Logger.new("the.log")
Rails.logger = Logger.new(STDOUT)
$logger = Rails.logger

### application config
app_config_file = "/etc/xop/xoplogs.conf"
$app_config = {}
if File.exists?(app_config_file)
    File.open(app_config_file, "r") do |config_file|
      $app_config = YAML.load(config_file)      
      $logger.info "loaded application config from '#{app_config_file}'"
    end
  else
    $logger.warn "couldn't find application config - looked for #{app_config_file}"
end
    