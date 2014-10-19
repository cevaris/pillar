module Pillar

  
  class Worker
    include Pillar::Serialization

    attr_accessor :worker_id, :env, :args

    def initialize(params=nil)
      params ||= {env: {}, args: [] }
      params[:worker_id] = SecureRandom.hex
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def spawn
      system(@env, @args.join(' '))
    end

  end

end
