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
      puts @args
      raise "No file/script defined" if @args.empty?
      raise "File/Script does not exist: #{@args[0]}" if not File.exist?(@args[0])
      system(@env, @args.join(' '))
    end

  end

end
