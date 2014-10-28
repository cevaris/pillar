#!/usr/bin/env ruby

require 'fileutils'
require 'pidfile'
require 'logger'

PID_PATH  = '/tmp/pillar'
WORKER_ID = ENV['WORKER_ID']
PidFile.new(piddir: PID_PATH, pidfile: "pillar.#{WORKER_ID}.pid")

logger = Logger.new('/tmp/print-time.log')

puts "ruby #{ENV['MY_ENV']}"

loop do
  logger.debug "Checkin: #{Process.pid} #{Time.now.utc.to_i}"
  sleep 5
end