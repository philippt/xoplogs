class Nginx 
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end
  
  def parse(line)
    entry = nil

    #1294395876.597 [07/Jan/2011:10:24:36 +0000] 85.158.0.100 10.16.200.51 193.26.7.111, 10.16.200.62 304 0 0.000 - "GET /skin/frontend/RN/romania/images/sprites.png HTTP/1.0" "http://fundeal.ro/bucharest/" "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; IE7 (proprietar); .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0C; .NET4.0E; IE7 (proprietar))"
    result = /^([\d\.]+)\s+\[.+\]\s+(\S+)\s+([\d\.]+)\s+((?:[\d\.\w]+,\s)*[\d+\.\w]+)\s+(\d+)\s+(.+)\s+([\d\.]+)\s+(\S+)\s+"(\w+)\s+(\S+?)(?:\?(.+))?\s+(.+)"\s+"(.+)"\s+"(.+)"$/.match(line)
    if result then
      entry = {
        :log_ts => Time.at(result.captures[0].to_i),
        :http_host_name => result.captures[1],
      
        :remote_ip => result.captures[2],
        :x_forwarded_for => result.captures[3],
  
        :return_code => result.captures[4],
        :response_size_bytes => result.captures[5],
        :response_time_microsecs => result.captures[6].to_f * 1000 * 1000,
        :http_method => result.captures[8],
        :method_name => result.captures[9],
        :query_string => result.captures[10],
        :http_version => result.captures[11],
        :referrer => result.captures[12],
        :user_agent => result.captures[13]
      
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
#      entry.md5_checksum = Digest::MD5.hexdigest(
#        entry.log_ts.to_s +
#        entry.remote_ip + entry.x_forwarded_for +
#        entry.method_name +
#        entry.host_name + entry.service_name +
#        entry.response_size_bytes.to_s + entry.response_time_microsecs.to_s
#      )
    end

    entry
  end
  
end