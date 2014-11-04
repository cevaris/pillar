module Pillar
  
  class Configuration
    # include Pillar::Serialization

    attr_accessor :hosts
    attr_accessor :log_path
    attr_accessor :pid_dir
    attr_accessor :etcd_hosts
     
    def initialize
      @hosts      = ['127.0.0.1']
      @etcd_hosts = '127.0.0.1'
      @log_path   = LOG_PATH
      @pid_dir    = PID_DIR
      
      FileUtils::mkdir_p PID_DIR

      PidFile.new(piddir: PID_DIR, pidfile: PID_FILE)
    end
  end
     
end
