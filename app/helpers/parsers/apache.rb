#require 'helpers/parsers/xop_apache'

class Apache < XopApache

    # apache combined format  
    # 10.60.10.3 - - [13/Oct/2012:23:44:44 +0200] "GET /logging/today HTTP/1.1" 304 - "http://dev.virtualop.org/logging/" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:16.0) Gecko/20100101 Firefox/16.0"
    # 10.60.10.3 - - [13/Oct/2012:23:57:27 +0200] "GET /css/tabs.css HTTP/1.1" 304 - "http://website.dev.virtualop.org/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:16.0) Gecko/20100101 Firefox/16.0"

  def parse(line)
    entry = nil

    result = /([\d\.]+)\s+-\s+-\s+\[([^\]]+)\]\s+"(\w+)\s+(\S+?)(?:\?(.+))?\s+(.+)"\s+(\d+)\s+-\s+\"([^"]+)\"\s+\"([^"]+)\"/.match(line)
    #result = /([\d\.]+)\s+-\s+-\s+\[([^\]]+)\]\s+\"([^"]+)\"\s+(\d+)\s+-\s+\"([^"]+)\"\s+\"([^"]+)\"\s+\"([^"]+)\"/.match(line)    
    if result then
      entry = {
        :log_ts => DateTime.strptime(result.captures[1], "%d/%b/%Y:%H:%M:%S %z"),
        #:http_host_name => result.captures[1],
      
        :remote_ip => result.captures[0],
  
        :return_code => result.captures[6],
        
        :http_method => result.captures[2],        
        :method_name => result.captures[3],
        :query_string => result.captures[4],
        :http_version => result.captures[5],
        
        :referrer => result.captures[7],
        :user_agent => result.captures[8]
      
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