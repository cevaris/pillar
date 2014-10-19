module Pillar
  
  class Configuration
    attr_accessor :hosts, :log_path
     
    def initialize
      @hosts    = ['127.0.0.1']
      @log_path = '/var/log/pillar.log'
    end
  end
     
end
