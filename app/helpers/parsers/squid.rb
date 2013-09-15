require 'parsers/regex_linebased'

class Squid < RegexLinebased
  
  def regex
    # 0          1        2 3             4           5   6      7  8                  9        10     11
    # 1359729410.424      2 188.40.33.145 TCP_MEM_HIT/200 29978 GET http://foo.com/bar philippt NONE/- application/x-rpm
    # 1359729410.424  2      188.40.33.145 TCP_MEM_HIT/200 29978   GET     http...  phil..  NONE/- application/x-rpm
    /(\d+)\.(\d+)\s+(\d+)\s+([\d\.]+)\s+([\w_]+)\/(\d+)\s+(\d+)\s+(\w+)\s+(\S+)\s+(\w+)\s+(\S+)\s+(.+)/
  end
  
  def mapping
    {
      :log_ts_block => lambda { |x| Time.at(x[0].to_i) },
      :response_time_microsecs_block => lambda { |x| x[2] * 1000 },
      :remote_ip => 3,
      :cache_state => 4,
      :return_code => 5,
      :response_size_bytes => 6,
      :http_method => 7
      #:method_name => 8,
    }    
  end
  
end