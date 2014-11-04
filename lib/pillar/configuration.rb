module Pillar
  
  class Configuration
    # include Pillar::Serialization

    attr_accessor :hosts
    attr_accessor :log_path
    attr_accessor :etcd_hosts
     
    def initialize
      @hosts      = ['127.0.0.1']
      @etcd_hosts = '127.0.0.1'
      @log_path   = '/var/log/pillar.log'
      
      FileUtils::mkdir_p PID_PATH

      PidFile.new(piddir: PID_PATH, pidfile: PID_FILE)
    end
  end
     
end
