class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :evaluate_filter_params, :prepare_hostlist
  
  def evaluate_filter_params
    @date_format = "%d.%m.%Y %H:%M:%S %Z"

    @start_ts = nil
    @stop_ts = Time.now()

    # interval_hours
    # if an interval is specified (combo box), we should use this
    if (params.has_key?(:interval_hours) && params[:interval_hours].to_i > 0)
      @start_ts = @stop_ts - (60 * 60 * params[:interval_hours].to_i)
    else
      # start_ts/stop_ts
      # if no start/stop_ts params are set, try to use start/stop_text
      if (params.has_key?(:start_ts))
        @start_ts = Time.at(params[:start_ts].to_i)
      elsif (params.has_key?(:start_text))
        @start_ts = DateTime.strptime(params[:start_text], @date_format).utc.to_time
      end

      if (params.has_key?(:stop_ts))
        @stop_ts = Time.at(params[:stop_ts].to_i)
      elsif (params.has_key?(:stop_text))
        @stop_ts = DateTime.strptime(params[:stop_text], @date_format).utc.to_time
      else
        @stop_ts = Time.now()
      end
    end

    if (@start_ts == nil)
      # show the last week by default
      params[:interval_hours] = 24 * 7
      @start_ts = @stop_ts - (60 * 60 * params[:interval_hours].to_i)
    end

    $logger.debug  "+++ start_ts is : #{@start_ts.utc}"
    $logger.debug  "+++ stop_ts is : #{@stop_ts.utc}"
    

    @filters = params

    #@filters[:bucket_count] = 40

    @current_params = {}
    @current_params["start_ts"] = @start_ts.utc.to_i
    @current_params["stop_ts"] = @stop_ts.utc.to_i

    current_filters = "start_ts=#{@start_ts.utc.to_i}&stop_ts=#{@stop_ts.utc.to_i}"
    [:services, :hosts].each do |param|
      if params[param]
        params[param].each do |h|
          current_filters += "&#{param}[]=#{h}"
        end
        @current_params[param.to_s + "[]"] = params[param]
      end
    end

    if (params.has_key?(:interval_hours))
      current_filters += "&interval_hours=#{params[:interval_hours]}"
      @current_params["interval_hours"] = params[:interval_hours]
    end

    # TODO think about adding the other filters here
    @current_filters = current_filters
    puts "*** params ***"
    p @current_params
  end

  def prepare_hostlist
    @imported_host_list = ImportedFile.find_distinct('host_name')
    
    @raw_data_host_list = (HttpAccessEntryTable.find_all_hosts + ServerLogTable.find_all_hosts).uniq   
    
    @host_list = (AccessByHostPerDay.find_distinct(@start_ts, @stop_ts, 'host_name') +
                 SlStatsByHostPerDay.find_distinct(@start_ts, @stop_ts, 'host_name')).uniq
  end  
  
end
