module Pillar
  
  class Agent
  end

  class ControllerAgent < Agent
    def initialize(host)
      super

      @host = host
      @nodes = ['127.0.0.1:5000'] # Query Etcd
    end
  end

  class NodeAgent < Agent
    def initializes
    end

  end

end
