module Pillar

  
  class Worker
    include Pillar::Serialization

    attr_accessor :worker_id, :args, :daemon
    alias_method :is_daemon?, :daemon

    def initialize(params=nil)
      params['args']      ||= ""
      params['worker_id'] ||= SecureRandom.hex
      params['host']      ||= HOSTNAME
      params['daemon']    = true if params['daemon'].nil?
      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def spawn
      # @args << '&'
      raise "No file/script defined" if @args.empty?
      # raise "File/Script does not exist: #{@args[0]}" if not File.exist?(@args[0])
      raise "Valid File/Script not found in: #{@args}" if @args.split(' ').select {|f| File.exist?(f)}.empty?
      puts "Executing #{@args}"
      # (pid = fork) ? (Process.detach(pid); puts "Executed child PID#{pid}") : exec(@args.join(' '))
      pid = Process.spawn({ 'WORKER_ID' => @worker_id }, @args)
      Process.detach(pid) if pid
      # (pid = fork) ? (Process.detach(pid); puts "Executed child PID#{pid}") : exec(@args.join(' '))
    end

  end

end
