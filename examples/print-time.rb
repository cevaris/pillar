#!/usr/bin/env ruby

require 'pillar'

Pillar.configure do |config|
  config.hosts = ['127.0.0.1']
end

logger = Logger.new('/tmp/print-time.log')

puts "ruby #{ENV['MY_ENV']}"

loop do
  logger.debug "Checkin: #{Process.pid} #{Time.now.utc.to_i}"
  sleep 5
end