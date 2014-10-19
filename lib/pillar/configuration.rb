module Pillar
  
  class Configuration
    # include Pillar::Serialization

    attr_accessor :hosts, :log_path, :pid_dir
     
    def initialize
      @hosts    = ['127.0.0.1']
      @log_path = '/var/log/pillar.log'
      @pid_dir  = '/tmp/pillar'
    end
  end
     
end
