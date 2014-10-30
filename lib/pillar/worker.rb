module Pillar

  
  class Worker
    include Pillar::Serialization

    attr_accessor :worker_id, :args

    def initialize(params=nil)
      params['args']      ||= []
      params['worker_id'] ||= SecureRandom.hex
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def spawn
      # @args << '&'
      raise "No file/script defined" if @args.count < 1
      # raise "File/Script does not exist: #{@args[0]}" if not File.exist?(@args[0])
      raise "Valid File/Script not found: #{@args}" if @args.select {|f| File.exist?(f)}.empty?
      puts "Execting #{@args}"
      # (pid = fork) ? (Process.detach(pid); puts "Executed child PID#{pid}") : exec(@args.join(' '))
      pid = Process.spawn({ 'WORKER_ID' => @worker_id }, @args.join(' '))
      Process.detach(pid) if pid
      # (pid = fork) ? (Process.detach(pid); puts "Executed child PID#{pid}") : exec(@args.join(' '))
    end

  end

end
