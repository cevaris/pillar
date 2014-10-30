module Pillar

  class Controller
    def initialize
      puts Pillar.configuration.inspect
    end
    def self.rackup
      SinatraController.run!
    end
  end
  
  class SinatraController < Sinatra::Base
      get '/v1/' do
        {status: 'ok'}.to_json
      end

      get '/v1/host' do
        {host: Pillar::HOSTNAME}.to_json
      end

      post '/v1/workers/' do
        request.body.rewind
        payload = JSON.parse request.body.read

        # puts "Path:#{payload['args']}"
        worker = Pillar::Worker.new 'args' => payload['args'], 
                                    'daemon' => payload['args'], 
                                    'host' => Pillar::HOSTNAME
        puts "Worker: #{worker.inspect}"

        worker.to_json
      end
  end

end
