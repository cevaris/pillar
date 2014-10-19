module Pillar

  
  class Worker
    include Pillar::Serialization

    attr_accessor :env, :args

    def initialize(params=nil)
      params ||= { env: {}, args: [] }
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

  end

end
