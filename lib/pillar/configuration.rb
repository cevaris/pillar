module Pillar
  
  class Configuration
    # include Pillar::Serialization

    attr_accessor :hosts
    attr_accessor :log_path
    attr_accessor :pid_dir
    attr_accessor :etcd_hosts
     
    def initialize
      @hosts      = ['127.0.0.1']
      @etcd_hosts = ['127.0.0.1']
      @log_path   = '/var/log/pillar.log'
      @pid_dir    = '/tmp/pillar'
    end
  end
     
end
