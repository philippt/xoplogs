run_command "`which rails` s -p 3001"

http_endpoint 3001

process_regex 'rails s -p 3001'

# TODO rails 3001 