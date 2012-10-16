class CreateAccessStats < ActiveRecord::Migration

  def self.intervals
    ["secs", "mins", "hours", "days"]
  end

  def self.add_aggregation_columns(t)
    t.column :success_count, :integer
    t.column :failure_count, :integer

    t.column :response_time_micros_min, :integer
    t.column :response_time_micros_max, :integer
    t.column :response_time_micros_avg, :integer
    t.column :response_time_micros_stddev, :integer
  end

  def self.up
    # overall stats
    intervals.each do |interval|
      create_table "access_per_#{interval}" do |t|
        t.column :log_ts, :timestamp

        add_aggregation_columns(t)
      end
    end

    # grouped by host
    intervals.each do |interval|
      create_table "access_by_host_per_#{interval}" do |t|
        t.column :log_ts, :timestamp
        t.column :host_name, :string, :limit => 200

        add_aggregation_columns(t)
      end
    end

    # grouped by host and service
    intervals.each do |interval|
      create_table "access_by_service_per_#{interval}" do |t|
        t.column :log_ts, :timestamp
        t.column :host_name, :string, :limit => 200
        t.column :service_name, :string, :limit => 200

        add_aggregation_columns(t)
      end
    end
  end

  def self.down
    ["", "by_host_", "by_service_"].each do |name_fragment|
      intervals.each do |interval|
        drop_table "access_#{name_fragment}per_#{interval}"
      end
    end
  end
end
