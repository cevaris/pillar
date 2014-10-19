module Pillar


  module Serialization

    def to_json(*a)
      hash = {}
      instance_variables.collect {|x| hash[x.to_s.tr('@','')]= instance_variable_get(x) }
      {
        'json_class'   => self.class.name,
        'data'         => hash
      }.to_json(*a)
    end

    def self.from_json(o)
      o = JSON.parse o if o.class == String

      clazz = Module.const_get o['json_class']
      # puts o.inspect
      clazz.new(o['data'])
    end

  end
  
  class Worker
    include Serialization

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
