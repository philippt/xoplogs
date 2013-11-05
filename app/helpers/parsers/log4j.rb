class Log4j
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end
  
  def parse(line)
    # this works with a log4j config like
    #   <param name="ConversionPattern" value="%d [%t] %-5p %c - %m%n" />
    #
    # 2013-11-05 15:53:54,252 [main] INFO  org.apache.catalina.startup.Catalina - Server startup in 126 ms
    
              #0                1         2        3
    pattern = /([\d\s:,-]+)\s+\[(\S+)\]\s+(\S+)\s+(.+?)\s+-\s+(.+)$/
    
    matched = pattern.match(line)
    if matched
      begin
        {
          :log_ts => DateTime.parse(matched.captures[0]),
          :host_name => @host_name,
          :service_name => @service_name,
          :log_level => matched.captures[2],
          :class_name => matched.captures[3],
          :message => matched.captures[4].strip.chomp,
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