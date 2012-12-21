run_command '`which rails` runner app/scripts/aggregate.rb', :spawn => 5

process_regex "app/scripts/aggregate.rb"

