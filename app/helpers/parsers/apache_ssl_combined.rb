class ApacheSslCombined

  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end
  
  def parse(line)
    entry = nil
    
    #Logformat "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b \"%{Referer}i\" \"%{User-Agent}i\"" ssl_combined
    
    # [06/Nov/2012:14:28:15 +0100] 213.23.84.204 TLSv1 RC4-MD5 "GET /css/RSP.style.css HTTP/1.1" - "-" "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; MDDR; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MSOffice 12)"
    # 1:"06/Nov/2012:14:28:15 +0100" 2:"213.23.84.204" 3:"TLSv1" 4:"RC4-MD5" 5:"GET" 6:"/css/RSP.style.css" 7:nil 8:"HTTP/1.1" 9:"-" 10:"-" 11:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; MDDR; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MSOffice 12)"
    result = /\[(.+)\]\s+([\d\.\w]+)\s+(\S+)\s+(\S+)\s+"(\w+)\s+(\S+?)(?:\?(.+))?\s+(.+)"\s+([\d-]+)\s+"([^"]+)"\s+(.+?)\s*$/.match(line)
    if result then
      entry = {
        #:log_ts => Time.at(result.captures[0].to_i),
        :log_ts => DateTime.strptime(result.captures[0], "%d/%b/%Y:%H:%M:%S %z"),
        #:http_host_name => result.captures[1],
      
        :remote_ip => result.captures[1],
        #:x_forwarded_for => result.captures[3],
  
        #:return_code => result.captures[8],
        :response_size_bytes => result.captures[8],
        #:response_time_microsecs => result.captures[6],
        :http_method => result.captures[4],
        :method_name => result.captures[5],
        :query_string => result.captures[6],
        :http_version => result.captures[7],
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