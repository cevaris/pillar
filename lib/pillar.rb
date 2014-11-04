require 'securerandom'
require 'pp'
require 'time'
require 'logger'
require 'fileutils'

require 'etcd'
require 'pidfile'
require 'listen'
require 'sinatra'
require "sinatra/base"
require 'socket'


require "pillar/version"
require "pillar/util"
require "pillar/json"
require "pillar/worker"
require "pillar/controller"
require "pillar/configuration"


module Pillar

  HOSTNAME  = Socket.gethostname
  WORKER_ID = ENV['WORKER_ID'] || 'server'
  PID_PATH  = '/tmp/pillar'
  PID_FILE  = "pillar.#{WORKER_ID}.pid"


  class << self
    attr_accessor :configuration
  end
     
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # def self.client_setup
  #   self.configuration ||= Configuration.new
  #   # Confirm directory exits
  #   FileUtils::mkdir_p Pillar.configuration.pid_dir
  #   # Create pillar pid file
  #   # PidFile.new(piddir: Pillar.configuration.pid_dir, pidfile: "pillar.#{Process.pid}.pid")
  # end
     
end

