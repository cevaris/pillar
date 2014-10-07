require 'etcd'
require 'securerandom'
require 'pp'

require "pillar/version"


HOSTS='127.0.0.1'



module Pillar
end

module Etcd
  def self.connect
    Etcd.client( host: HOSTS, port: 4001 )
  end
  def self.get(path)
    begin
      client = self.connect
      client.get(path)
    rescue Etcd::KeyNotFound
      nil
    end 
  end
  def self.set(path, value)
    client = self.connect
    client.set(path, value: value)
  end

  def self.default_worker
    self.set("/registrar/#{SecureRandom.hex}", {task: 'default'})
  end

  def self.delete(path)
    client = self.connect
    client.delete(path, recursive: true)
  end
end

# Watches and executes on action
class ProcessWatcher
  def initialize
    @path = path
  end

  def self.watch
  end
end


# 0,* ProcessWorkers
# Can be ran on different machines
class ProcessWorker
  def execute
    @watcher = self.checkin
  end

  def task
  end

  def checkin
    puts Etcd.get('/registrar')
  end
end


class Supervisor


  def setup
    registrar = Etcd.get('/registrar')

    unless registrar
      puts 'Setting up'
      2.times { Etcd.default_worker }
      registrar = Etcd.get('/registrar')
    end

    registrar.node.children.each do |n|
      
      fork do
        puts n.inspect
        
        puts 'Starting worker'
        puts "Hello from fork pid: #{Process.pid}"
        $0 = "ruby #{worker_klass.worker_name}"
      end
      
    end
    
  end

end

