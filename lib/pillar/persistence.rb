module Pillar

  class Persistance
    def get_client; raise NotImplementedError end 
    def save(obj);  raise NotImplementedError end
  end
  
  class EtcdWorker < Persistance
    def self.get_client
      Etcd.client( host: Pillar.configuration.etcd_hosts, port: 4001 )
    end

    def self.save(obj)
      client = self.get_client
      client.set("/workers/#{obj.worker_id}", value: obj.to_json)
    end
  end

end
