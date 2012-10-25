class JbossServerLog
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end
  
  def parse(line)
    entry = nil
    
    # 2012-10-22 00:00:30,375 DEBUG [com.arjuna.ats.arjuna.logging.arjLogger] (Thread-12) Periodic recovery - first pass <Mo, 22 Okt 2012 00:00:30>
    # 2012-10-22 00:00:30,375 DEBUG [com.arjuna.ats.arjuna.logging.arjLogger] (Thread-12) StatusModule: first pass
    # 2012-10-22 00:00:30,375 DEBUG [com.arjuna.ats.txoj.logging.txojLoggerI18N] (Thread-12) [com.arjuna.ats.internal.txoj.recovery.TORecoveryModule_3] - TORecoveryModule - first pass
    
              #0              1         2               3           4
    pattern = /([\d\s:,-]+)\s+(\w+)\s+\[([\w\.]+)\]\s+\(([^)]+)\)\s+(.+)/
    #pattern = /([\d-:,.]+)\s+(\w+)\s+\[([\w\.]+)\]\s+\(([^)]+)\)\s+(.+)/
    
    result = pattern.match(line)
    if result then
      entry = {
        #:log_ts => DateTime.strptime(result.captures[1], "%Y-%m-%d %H:%M:%S,%L"),
        :log_ts => DateTime.parse(result.captures[0]),
        :host_name => @host_name,
        :service_name => @service_name,
        :log_level => result.captures[1],
        :class_name => result.captures[2],
        :message => result.captures[4].strip.chomp,
        :stacktrace => '' 
      }
    else
      # not the start of a new entry
      if entry
        # append to stacktrace
      end
    end
    entry
  end
  
end