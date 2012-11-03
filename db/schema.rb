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

  create_table "hae_ramirez_zapata_virtualop_apache_20120924", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_ramirez_zapata_virtualop_apache_20120924", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_ramirez_zapata_virtualop_apache_20120924", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_ramirez_zapata_virtualop_apache_20120924", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_ramirez_zapata_virtualop_apache_20120924", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_ramirez_zapata_virtualop_apache_20120925", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_ramirez_zapata_virtualop_apache_20120925", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_ramirez_zapata_virtualop_apache_20120925", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_ramirez_zapata_virtualop_apache_20120925", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_ramirez_zapata_virtualop_apache_20120925", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_ramirez_zapata_virtualop_apache_20120930", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_ramirez_zapata_virtualop_apache_20120930", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_ramirez_zapata_virtualop_apache_20120930", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_ramirez_zapata_virtualop_apache_20120930", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_ramirez_zapata_virtualop_apache_20120930", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_19700101", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_19700101", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_19700101", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_19700101", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_19700101", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120916", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120916", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120916", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120916", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120916", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120917", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120917", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120917", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120917", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120917", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120918", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120918", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120918", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120918", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120918", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120919", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120919", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120919", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120919", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120919", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120920", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120920", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120920", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120920", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120920", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120921", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120921", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120921", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120921", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120921", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120922", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120922", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120922", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120922", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120922", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120923", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120923", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120923", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120923", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120923", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120924", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120924", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120924", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120924", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120924", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120925", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120925", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120925", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120925", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120925", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120926", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120926", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120926", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120926", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120926", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120927", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120927", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120927", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120927", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120927", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120928", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120928", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120928", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120928", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120928", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120929", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120929", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120929", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120929", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120929", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20120930", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120930", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120930", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120930", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20120930", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121001", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121001", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121001", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121001", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121001", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121002", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121002", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121002", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121002", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121002", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121003", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121003", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121003", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121003", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121003", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121004", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121004", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121004", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121004", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121004", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121005", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121005", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121005", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121005", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121005", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121006", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121006", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121006", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121006", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121006", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121007", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121007", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121007", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121007", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121007", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121008", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121008", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121008", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121008", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121008", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121009", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121009", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121009", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121009", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121009", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121010", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121010", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121010", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121010", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121010", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121011", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121011", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121011", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121011", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121011", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121012", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121012", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121012", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121012", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121012", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121013", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121013", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121013", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121013", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121013", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121014", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121014", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121014", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121014", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121014", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121015", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121015", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121015", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121015", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121015", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121016", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121016", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121016", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121016", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121016", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121017", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121017", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121017", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121017", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121017", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121018", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121018", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121018", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121018", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121018", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_vopdev20120811_zapata_virtualop_apache_20121019", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121019", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121019", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121019", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_vopdev20120811_zapata_virtualop_apache_20121019", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120916", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120916", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120916", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120916", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120916", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120917", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120917", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120917", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120917", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120917", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120918", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120918", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120918", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120918", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120918", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120919", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120919", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120919", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120919", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120919", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120920", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120920", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120920", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120920", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120920", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120921", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120921", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120921", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120921", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120921", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120922", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120922", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120922", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120922", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120922", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120923", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120923", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120923", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120923", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120923", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120924", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120924", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120924", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120924", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120924", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120925", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120925", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120925", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120925", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120925", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120926", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120926", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120926", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120926", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120926", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120927", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120927", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120927", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120927", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120927", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120928", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120928", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120928", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120928", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120928", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120929", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120929", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120929", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120929", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120929", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20120930", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20120930", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120930", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20120930", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20120930", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121001", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121001", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121001", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121001", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121001", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121002", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121002", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121002", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121002", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121002", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121003", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121003", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121003", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121003", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121003", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121004", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121004", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121004", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121004", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121004", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121005", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121005", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121005", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121005", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121005", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121006", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121006", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121006", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121006", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121006", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121007", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121007", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121007", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121007", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121007", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121008", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121008", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121008", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121008", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121008", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121009", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121009", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121009", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121009", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121009", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121010", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121010", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121010", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121010", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121010", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121011", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121011", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121011", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121011", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121011", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121012", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121012", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121012", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121012", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121012", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121013", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121013", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121013", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121013", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121013", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121014", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121014", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121014", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121014", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121014", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121015", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121015", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121015", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121015", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121015", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121016", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121016", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121016", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121016", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121016", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121017", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121017", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121017", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121017", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121017", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121018", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121018", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121018", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121018", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121018", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121019", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121019", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121019", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121019", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121019", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121020", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121020", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121020", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121020", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121020", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121021", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121021", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121021", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121021", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121021", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121022", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121022", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121022", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121022", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121022", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121023", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121023", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121023", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121023", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121023", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121024", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121024", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121024", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121024", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121024", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121025", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121025", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121025", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121025", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121025", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121026", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121026", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121026", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121026", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121026", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121027", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121027", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121027", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121027", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121027", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121028", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121028", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121028", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121028", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121028", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121029", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121029", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121029", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121029", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121029", ["service_name"], :name => "index_http_access_entries_on_service_name"

  create_table "hae_website_cabildo_virtualop_apache_20121030", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_string",            :limit => 1024
    t.integer  "aggregated_flag"
  end

  add_index "hae_website_cabildo_virtualop_apache_20121030", ["host_name"], :name => "index_http_access_entries_on_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121030", ["http_host_name"], :name => "index_http_access_entries_on_http_host_name"
  add_index "hae_website_cabildo_virtualop_apache_20121030", ["log_ts"], :name => "index_http_access_entries_on_log_ts"
  add_index "hae_website_cabildo_virtualop_apache_20121030", ["service_name"], :name => "index_http_access_entries_on_service_name"

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
