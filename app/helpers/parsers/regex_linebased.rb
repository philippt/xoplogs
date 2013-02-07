class RegexLinebased
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
    @idx = 0
  end
  
  def regex
    raise "please implement regex"
  end
  
  def mapping
    raise "please implement mapping"
  end
  
  def post_process(entry)
    
  end
  
  def parse(line)
    entry = nil
    @idx += 1

    result = regex.match(line)
    if result then
      entry = {}
      mapping.each do |key, idx|        
        value = nil
        if block_matched = /(.+)_block/.match(key.to_s)
          begin
            value = mapping[key].call(result.captures)
            key = block_matched.captures.first.to_sym
          rescue => error
            $logger.warn("problem executing parse-block for #{key} on line #{@idx} : #{error.message}")
          end
        else
          value = result.captures[idx]
        end
        
        entry[key] = value
      end
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
      
      post_process(entry)
    end

    entry
  end
  
end