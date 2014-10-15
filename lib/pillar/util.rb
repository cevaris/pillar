module Pillar
  def self.epoch
    Time.now.utc.to_i
  end
  def self.now 
    Time.now.utc.iso8601
  end
end