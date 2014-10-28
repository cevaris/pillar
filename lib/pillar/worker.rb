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
      # @args << '&'
      @env['WORKER_ID'] = @worker_id
      raise "No file/script defined" if @args.count < 1
      raise "File/Script does not exist: #{@args[0]}" if not File.exist?(@args[0])
      puts "Execting #{@args}"
      # (pid = fork) ? (Process.detach(pid); puts "Executed child PID#{pid}") : exec(@args.join(' '))
      pid = Process.spawn(@env, @args.join(' '))
      Process.detach(pid) if pid
      # (pid = fork) ? (Process.detach(pid); puts "Executed child PID#{pid}") : exec(@args.join(' '))
    end

  end

end
