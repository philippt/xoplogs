class Log4j
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end
  
  def parse(line)
    # 2013-11-04 17:18:52,356 INFO : de.comline.gkvsv.phmv.home.controller.HomeController - Welcome home! the client locale is de
    
              #0              1            2           3
    #pattern = /([\d\s:,-]+)\s+(\w+)\s+:\s+(\S+)\s+-\s+(.+)$/
    pattern = /([\d\s:,-]+)\s+(\S+)\s+(\S+)\s*(\w+):\s+(.+)/m
    
    matched = pattern.match(line)
    if matched
      begin
        {
          :log_ts => DateTime.parse(matched.captures[0]),
          :host_name => @host_name,
          :service_name => @service_name,
          :log_level => matched.captures[1],
          :class_name => matched.captures[2],
          :message => matched.captures[3].strip.chomp,
          :stacktrace => '' 
        }
      rescue => detail
        $logger.warn("could not parse line #{line} : #{detail.message}")
        nil
      end
    else
      nil
    end
  end
  
end