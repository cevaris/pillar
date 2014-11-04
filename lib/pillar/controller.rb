module Pillar

  class Controller
    def initialize
      puts Pillar.configuration.inspect
    end
  end
  
  class SinatraController < Sinatra::Base
    set :port, 4444

    get '/v1/' do
      {status: 'ok'}.to_json
    end

    get '/v1/host' do
      {host: "#{Pillar::HOSTNAME}:#{settings.port}"}.to_json
    end

    post '/v1/workers/' do
      request.body.rewind
      payload = JSON.parse request.body.read

      worker = Pillar::Worker.new 'args' => payload['args'], 
                                  'daemon' => payload['daemon']
      puts "Worker: #{worker.inspect}"

      Pillar::EtcdWorker.save(worker)

      worker.to_json
    end
  end

end
