gem 'etcd'

require "pillar/version"

module Pillar
  # Your code goes here...
end


class ProcessWatcher
  def initialize path
    @path = path
  end
  def self.watch
  end
end

=begin
0,* ProcessWorkers
Can be ran on different machines
=end
class ProcessWorker

  HOSTS=['localhost']

  def execute
    @watcher = self.checkin
  end

  def checkin
    client = Etcd.client(host: HOSTS, port: 4003 )
    puts client.inspect
    ProcessWorker.new 'custom-path'
  end
end