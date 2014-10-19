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
end