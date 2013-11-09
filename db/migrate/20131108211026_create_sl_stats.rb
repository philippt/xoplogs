class CreateSlStats < ActiveRecord::Migration
  
  def self.intervals
    [ "mins", "hours", "days" ]
  end
  
  def self.add_aggregation_columns(t)
    %w|debug info warn error|.each do |log_level|
      t.column "#{log_level}_count".to_sym, :integer
    end
  end
  
  def self.up
    # overall stats
    intervals.each do |interval|
      table_name = "sl_stats_per_#{interval}"
      create_table table_name, :id => false do |t|
        t.column :log_ts, :timestamp        

        add_aggregation_columns(t)
      end
      ActiveRecord::Base.connection.execute("ALTER TABLE #{table_name} ADD PRIMARY KEY (log_ts)")
    end

    # grouped by host
    intervals.each do |interval|
      table_name = "sl_stats_by_host_per_#{interval}"
      create_table table_name, :id => false do |t|
        t.column :log_ts, :timestamp
        t.column :host_name, :string, :limit => 200


        add_aggregation_columns(t)
      end
      ActiveRecord::Base.connection.execute("ALTER TABLE #{table_name} ADD PRIMARY KEY (log_ts, host_name)")
    end

    # grouped by host and service
    intervals.each do |interval|
      table_name = "sl_stats_by_service_per_#{interval}"
      create_table table_name, :id => false do |t|
        t.column :log_ts, :timestamp
        t.column :host_name, :string, :limit => 200
        t.column :service_name, :string, :limit => 200

        add_aggregation_columns(t)
      end
      ActiveRecord::Base.connection.execute("ALTER TABLE #{table_name} ADD PRIMARY KEY (log_ts, host_name, service_name)")
    end
  end

  def self.down
    ["", "by_host_", "by_service_"].each do |name_fragment|
      intervals.each do |interval|
        drop_table "sl_stats_#{name_fragment}per_#{interval}"
      end
    end
  end
end
