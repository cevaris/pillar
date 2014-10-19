module Pillar
  
  class Worker
    attr_accessor :env, :args

    def initialize(env={}, args=['/bin/bash'])
      @env  = env
      @args = args
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

    def as_json(options = { })
        {
            "json_class" => self.class.name,
            "data" => [ env, args ]
        }
    end
    def to_json(*a)
        as_json.to_json(*a)
    end
    def self.json_create(o)
        new o["data"]["elements"]
    end

    # def to_json(*a)
    #   {
    #     'json_class'   => self.class.name,
    #     'data'         => [ env, args ]
    #   }.to_json(*a)
    # end

    def self.json_create(o)
      new(*o['data'])
    end
  end

end
