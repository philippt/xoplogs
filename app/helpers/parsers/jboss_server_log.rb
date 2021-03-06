class JbossServerLog
  
  def initialize(host_name, service_name)
    @host_name = host_name
    @service_name = service_name
  end
  
  def parse(line)
    # 2012-10-22 00:00:30,375 DEBUG [com.arjuna.ats.arjuna.logging.arjLogger] (Thread-12) Periodic recovery - first pass <Mo, 22 Okt 2012 00:00:30>
    # 2012-10-22 00:00:30,375 DEBUG [com.arjuna.ats.arjuna.logging.arjLogger] (Thread-12) StatusModule: first pass
    # 2012-10-22 00:00:30,375 DEBUG [com.arjuna.ats.txoj.logging.txojLoggerI18N] (Thread-12) [com.arjuna.ats.internal.txoj.recovery.TORecoveryModule_3] - TORecoveryModule - first pass
    
              #0              1         2               3                4
    pattern = /([\d\s:,-]+)\s+(\w+)\s+\[([\w\.]+)\]\s+(?:\(([^)]+)\)\s+)?(.+)/
    
    matched = pattern.match(line)
    if matched
      {
        :log_ts => Time.at(DateTime.parse(matched.captures[0]).to_i - Time.zone.utc_offset).utc,
        :host_name => @host_name,
        :service_name => @service_name,
        :log_level => matched.captures[1],
        :class_name => matched.captures[2],
        :message => matched.captures[4].strip.chomp,
        :stacktrace => '' 
      }
    else
      nil
    end
  end
  
end