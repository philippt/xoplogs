#require 'helpers/parsers/xop_apache'

class Apache
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end

  def parse(line)
    entry = nil

    # apache combined format  
    # 10.60.10.3 - - [13/Oct/2012:23:44:44 +0200] "GET /logging/today HTTP/1.1" 304 - "http://dev.virtualop.org/logging/" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:16.0) Gecko/20100101 Firefox/16.0"
    # 10.60.10.3 - - [13/Oct/2012:23:57:27 +0200] "GET /css/tabs.css HTTP/1.1" 304 - "http://website.dev.virtualop.org/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:16.0) Gecko/20100101 Firefox/16.0"
    # 10.60.10.3  -   -    [13/Oct/2012:23:57:27 +0200] "GET /css/tabs.css HTTP/1.1" 304 - "http://website.dev.virtualop.org/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:16.0) Gecko/20100101 Firefox/16.0"
    
    result = /([\d\.]+)\s+-\s+(\S+)\s+\[([^\]]+)\]\s+"(\w+)\s+(\S+?)(?:\?(.+))?\s+(.+)"\s+(\d+)\s+([-\d]+)\s+\"([^"]+)\"\s+\"([^"]+)\"/.match(line)
    if result then
      entry = {
        :log_ts => DateTime.strptime(result.captures[2], "%d/%b/%Y:%H:%M:%S %z"),
        :basic_user => result.captures[1],
      
        :remote_ip => result.captures[0],
  
        :return_code => result.captures[7],
        
        :http_method => result.captures[3],        
        :method_name => result.captures[4],
        :query_string => result.captures[5],
        :http_version => result.captures[6],
        
        :response_size_bytes => result.captures[8],
        
        :referrer => result.captures[9],
        :user_agent => result.captures[10]
      
      }
    end

    # postprocess what we got
    if entry
      entry[:host_name] = @host_name
      entry[:service_name] = @service_name

      # for the source ip - if x-forwarded-for is set, it's the last part of
      # x-forwarded-for that is not "unknown", otherwise it's the remote_ip
      if (entry[:x_forwarded_for]) then
        parts = entry[:x_forwarded_for].split(", ")
        # TODO take the first part of the x_forwarded_for header
        parts.reverse.each do |part|
          if part != "unknown" && part != "unknownn" # this wasn't me...
            entry[:source_ip] = part
            break
          end
        end
      else
        entry[:source_ip] = entry[:remote_ip]
      end

      entry[:md5_checksum] = 42
    end

    entry
  end
  
end