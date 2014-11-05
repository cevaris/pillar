module Pillar

  class Persistance
    def get_client;  raise NotImplementedError end 
    def all;         raise NotImplementedError end 
    def save(obj);   raise NotImplementedError end
    def delete(obj); raise NotImplementedError end
  end
  
  class EtcdWorker < Persistance
    def self.get_client
      # Etcd.client( host: '127.0.0.1', port: 4001 )
      Etcd.client( host: Pillar.configuration.etcd_hosts, port: 4001 )
    end

    def self.all
      client = self.get_client
      client.get('/workers', {recursive: true, dir: true, sorted: true}).children.collect(&:value) || []
    end

    def self.save(obj)
      client = self.get_client
      client.set("/workers/#{obj.worker_id}", value: obj.to_json)
    end

    def self.delete(obj)
      client = self.get_client
      client.delete("/workers/#{obj.worker_id}")
    end
  end

end
