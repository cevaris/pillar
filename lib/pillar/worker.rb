module Pillar

  
  class Worker
    include Pillar::Serialization

    attr_accessor :env, :args

    def initialize(params=nil)
      params ||= { env: {}, args: ['/bin/bash'] }
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def self.configure
      worker      ||= Worker.new
      worker.env  ||= {}
      worker.args ||= ['/bin/bash']

      yield(worker)
    end

    def execute
      raise 'Method Not Implemented Error'
    end

  end

end
