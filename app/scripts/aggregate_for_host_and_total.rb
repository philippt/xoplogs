require 'rubygems'
require 'logger'
$logger = Logger.new("host_aggregator.log")

host_aggregator = HostAggregator.new
host_aggregator.run