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
    get '/' do
      {status: 'ok'}.to_json
    end

    post '/workers' do
      "Created new worker #{SecureRandom.hex}"
      worker = Worker.new
      {status: 'ok'}.to_json
    end
    
    get '/workers/:host/:hex' do
      ""
    end
  end

end
