class RubyLogger
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end
  
  def parse(line)
              #I, [2013-11-12T18:01:34.770319 #10815]  INFO -- : [ssh stop] result code : 127, output: 28 bytes
              #.          .                  .         .             .                    
    pattern = /(\w+),\s+\[([\d\s:,\.+-T]+)\s#(\d+)\]\s+(\w+)\s+--\s+:(.+)/
    
    matched = pattern.match(line)
    if matched
      begin
        {
          :log_ts => DateTime.parse(matched.captures[1]),
          :host_name => @host_name,
          :service_name => @service_name,
          :log_level => matched.captures[3],
          :class_name => '',
          :thread => matched.captures[2],
          :message => matched.captures[4] ? matched.captures[4].strip.chomp : '',
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

