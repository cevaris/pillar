require 'spec_helper'

module Pillar
	
	describe Worker do

		before(:each) do
	    Pillar.configure do |config|
			end
	  end

	  let(:default_worker) { Pillar::Worker.new }
	  let(:custom_worker) { Pillar::Worker.new(args: ['/location/of/my/script', '--arg==32'], env: {MY_ENV: '/tmp/dump'}) }

		describe "#args" do

	    it "should be be default" do
	    	expect(default_worker.args).to eq([])
			end

			it "should be be custom" do
				expect(custom_worker.args).to eq(['/location/of/my/script', '--arg==32'])
			end

	  end

	  describe "#env" do

	    it "should be be default" do
	    	expect(default_worker.env).to eq({})
			end

			it "should be be custom" do
				expect(custom_worker.env).to eq({MY_ENV: '/tmp/dump'})
			end

	  end



	  # describe "#log_path" do

			# it "should be be default" do
			# 	expect(Pillar::Worker.new.log_path).to eq('/var/log/pillar.log')
			# end

			# it "should be be custom" do
			# 	Pillar.configure do |config|
			# 		config.log_path = '/my/custom/path'
			# 	end
			# 	expect(Pillar::Worker.new.log_path).to eq('/my/custom/path')
			# end


	  # end
	
	end

end