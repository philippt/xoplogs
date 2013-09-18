run_command '`which rails` runner app/scripts/aggregate_for_host_and_total.rb'

process_regex "app/scripts/aggregate_for_host_and_total.rb"

