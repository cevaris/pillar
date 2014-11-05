module Pillar

  class Controller
    def initialize
      puts Pillar.configuration.inspect
    end
  end
  
  class SinatraController < Sinatra::Base
    set :port, 4444

    OK = {status: 'ok'}.to_json

    get '/v1/' do
      OK
    end

    get '/v1/host' do
      {host: "#{Pillar::HOSTNAME}:#{settings.port}"}.to_json
    end

    get '/v1/workers/' do
      {workers: Pillar::EtcdWorker.all.map {|w| w.from_json}}.to_json
    end

    delete '/v1/workers/:worker_id' do
      worker = worker_by_path("/workers/#{params[:worker_id]}")
      puts "Deleting worker #{worker.worker_id}"
      pidfile = "#{PID_DIR}/pillar.#{worker.worker_id}.pid"
      deleted_worker = Pillar::EtcdWorker.delete(worker)
      puts "Deleted from Etcd #{deleted_worker.inspect}"
      if File.exists?(pidfile)
        puts "Found file #{pidfile}"
        Process.kill(15, File.read(pidfile).to_i)
        puts "Killed worker"
      end
      OK
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
