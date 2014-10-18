require 'spec_helper'

module Pillar
	
	describe Configuration do

		before(:each) do
	    Pillar.configure do |config|
			end
	  end

		describe "#hosts" do

	    it "should be be default" do
	    	expect(Pillar.configuration.hosts).to eq(['127.0.0.1'])
			end

			it "should be be custom" do
				Pillar.configure do |config|
					config.hosts = ['127.0.0.1', '127.0.0.2', '127.0.0.3']
				end
				expect(Pillar.configuration.hosts).to eq(['127.0.0.1', '127.0.0.2', '127.0.0.3'])
			end

	  end


	  describe "#log_path" do

			it "should be be default" do
				expect(Pillar.configuration.log_path).to eq('/var/log/pillar.log')
			end

			it "should be be custom" do
				Pillar.configure do |config|
					config.log_path = '/my/custom/path'
				end
				expect(Pillar.configuration.log_path).to eq('/my/custom/path')
			end


	  end
	
	end

end