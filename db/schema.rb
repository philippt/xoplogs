# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121023121930) do

  create_table "access_by_host_per_days", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_by_host_per_hours", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_by_host_per_mins", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_by_host_per_secs", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_by_service_per_days", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.string   "service_name",                :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_by_service_per_hours", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.string   "service_name",                :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_by_service_per_mins", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.string   "service_name",                :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_by_service_per_secs", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",                   :limit => 200
    t.string   "service_name",                :limit => 200
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_per_days", :force => true do |t|
    t.datetime "log_ts"
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_per_hours", :force => true do |t|
    t.datetime "log_ts"
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_per_mins", :force => true do |t|
    t.datetime "log_ts"
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "access_per_secs", :force => true do |t|
    t.datetime "log_ts"
    t.integer  "success_count"
    t.integer  "failure_count"
    t.integer  "response_time_micros_min"
    t.integer  "response_time_micros_max"
    t.integer  "response_time_micros_avg"
    t.integer  "response_time_micros_stddev"
  end

  create_table "aggregator_statuses", :force => true do |t|
    t.integer  "last_aggregated_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.datetime "aggregated_up_to"
  end

  create_table "entries", :force => true do |t|
    t.datetime "log_ts"
    t.string   "request_id",   :limit => 200
    t.string   "service_name", :limit => 200
    t.string   "method_name",  :limit => 200
    t.string   "arguments"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "entry_points", :force => true do |t|
    t.string   "service_name", :limit => 200
    t.string   "method_name",  :limit => 200
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "flows", :force => true do |t|
    t.integer  "entry_point_id"
    t.integer  "idx"
    t.string   "name",           :limit => 200
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "http_access_entries", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",               :limit => 200
    t.string   "service_name",            :limit => 200
    t.string   "method_name",             :limit => 200
    t.string   "remote_ip",               :limit => 20
    t.string   "x_forwarded_for",         :limit => 100
    t.string   "source_ip",               :limit => 20
    t.string   "http_host_name",          :limit => 200
    t.string   "http_method",             :limit => 10
    t.string   "http_version",            :limit => 10
    t.integer  "return_code"
    t.integer  "response_size_bytes"
    t.integer  "response_time_microsecs"
    t.string   "user_agent",              :limit => 200
    t.string   "referrer",                :limit => 200
    t.string   "md5_checksum",            :limit => 100
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "http_access_entries", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "http_access_entries", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "http_access_entries", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "http_access_entries", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "http_access_entries_archive", :id => false, :force => true do |t|
    t.integer  "id",                                      :default => 0, :null => false
    t.datetime "log_ts"
    t.string   "host_name",               :limit => 200
    t.string   "service_name",            :limit => 200
    t.string   "method_name",             :limit => 200
    t.string   "remote_ip",               :limit => 20
    t.string   "x_forwarded_for",         :limit => 100
    t.string   "source_ip",               :limit => 20
    t.string   "http_host_name",          :limit => 200
    t.string   "http_method",             :limit => 10
    t.string   "http_version",            :limit => 10
    t.integer  "return_code"
    t.integer  "response_size_bytes"
    t.integer  "response_time_microsecs"
    t.string   "user_agent",              :limit => 200
    t.string   "referrer",                :limit => 200
    t.string   "md5_checksum",            :limit => 100
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  create_table "http_access_entry_tables", :force => true do |t|
    t.string   "host_name",             :limit => 200
    t.string   "service_name",          :limit => 200
    t.string   "the_day",               :limit => 10
    t.boolean  "needs_aggregation"
    t.integer  "active_aggregator_pid"
    t.datetime "last_aggregated_at"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.boolean  "is_archived",                          :default => false
  end

  create_table "imported_files", :force => true do |t|
    t.string   "host_name",           :limit => 200
    t.string   "service_name",        :limit => 200
    t.string   "file_name",           :limit => 200
    t.string   "md5sum",              :limit => 200
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "first_ts"
    t.datetime "last_ts"
    t.integer  "lines_read"
    t.integer  "lines_unparseable"
    t.integer  "lines_ignored_old"
    t.integer  "lines_processed"
    t.integer  "lines_total"
    t.integer  "processing_duration"
    t.integer  "import_duration"
  end

  create_table "server_log_tables", :force => true do |t|
    t.string   "host_name",             :limit => 200
    t.string   "service_name",          :limit => 200
    t.string   "the_day",               :limit => 10
    t.boolean  "needs_aggregation"
    t.integer  "active_aggregator_pid"
    t.datetime "last_aggregated_at"
    t.boolean  "is_archived",                          :default => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  create_table "server_logs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sl_sbk_hms_qs_app2_jboss_20121022", :force => true do |t|
    t.datetime "log_ts"
    t.string   "host_name",    :limit => 200
    t.string   "service_name", :limit => 200
    t.string   "log_level",    :limit => 10
    t.string   "class_name",   :limit => 200
    t.string   "message",      :limit => 200
    t.text     "stacktrace"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sl_sbk_hms_qs_app2_jboss_20121022", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "sl_sbk_hms_qs_app2_jboss_20121022", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "sl_sbk_hms_qs_app2_jboss_20121022", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "sql_statements", :force => true do |t|
    t.string   "statement",  :limit => 4000
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "steps", :force => true do |t|
    t.integer  "flow_id"
    t.integer  "idx"
    t.string   "service_name", :limit => 200
    t.string   "method_name",  :limit => 200
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

end
