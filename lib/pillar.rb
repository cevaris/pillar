require 'securerandom'
require 'pp'
require 'time'
require 'logger'

require 'etcd'
require 'pidfile'
require 'sinatra'
require "sinatra/base"

require "pillar/version"
require "pillar/util"
require "pillar/worker"
require "pillar/controller"
require "pillar/configuration"


module Pillar

  class << self
    attr_accessor :configuration
  end
     
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
     
end

# module Etcd
#   def self.connect
#     Etcd.client( host: HOSTS, port: 4001 )
#   end
#   def self.get(path)
#     begin
#       client = self.connect
#       client.get(path)
#     rescue Etcd::KeyNotFound
#       nil
#     end 
#   end
#   def self.set(path, value)
#     client = self.connect
#     client.set(path, value: value)
#   end

#   def self.default_worker
#     worker_uuid = SecureRandom.hex
#     self.set("/registry/#{worker_uuid}", {task: 'default'})
#   end

#   # def self.set_worker_id
#   #   self.set("/registry/#{SecureRandom.hex}", {task: 'default'})
#   # end

#   def self.delete(path)
#     client = self.connect
#     client.delete(path, recursive: true)
#   end
# end

# # Watches and executes on action
# class ProcessWatcher
#   def initialize
#     @path = path
#   end

#   def self.watch
#   end
# end


# # 0,* ProcessWorkers
# # Can be ran on different machines
# class ProcessWorker
#   def execute
#     @watcher = self.checkin
#   end

#   def task
#   end

#   def checkin
#     puts Etcd.get('/registry')
#   end
# end


# class Supervisor


#   def setup
#     registry = Etcd.get('/registry')

#     unless registry
#       puts 'Setting up'
#       2.times { Etcd.default_worker }
#       registry = Etcd.get('/registry')
#     end

#     registry.node.children.each do |n|
      
#       # fork do
#       #   puts n.inspect
        
#       #   puts 'Starting worker'
#       #   puts "Hello from fork pid: #{Process.pid}"
#       #   $0 = "ruby #{worker_klass.worker_name}"
#       # end
      
#     end
    
#   end

# end

