require 'spec_helper'

module Pillar
	
	describe Serialization do

		before(:each) do
	    Pillar.configure do |config|
			end
	  end


	  class JSONExample
	  	include Pillar::Serialization

	  	attr_accessor :var1, :var2

	    def initialize(params=nil)
	      params ||= { var1: 10, var2: 'test' }
	      params.each do |k,v|
	        instance_variable_set("@#{k}", v) unless v.nil?
	      end
	    end
	  end

	  let(:example) {JSONExample.new}
	  let(:example_json) {'{"json_class":"Pillar::JSONExample","data":{"var1":10,"var2":"test"}}'}
	  let(:e2_json) {'{"json_class":"Pillar::Worker", "data":{"worker_id":"1234b0f4f92ed924a71dd77d56ff2c79", "args":["/git/pillar/examples/print-time.rb"], "env":{"MY_ENV":"/tmp/dump/blah"} } }'}
  	

  	describe "#to_json" do

	    it "should be correct json" do
	    	expect(example.to_json.class).to eq(String)
	    	expect(example.to_json).to eq(example_json)
			end

	  end

	  describe "#from_json" do

	    it "should be correct object" do
	    	actual = Pillar::Serialization.from_json(example_json)
	    	expect(actual.var1).to eq(example.var1)
	    	expect(actual.var2).to eq(example.var2)
			end

			context 'from string' do

				it "should be correct object" do
		    	actual = example_json.from_json
		    	expect(actual.var1).to eq(example.var1)
		    	expect(actual.var2).to eq(example.var2)
				end

			end
			
		end

	end

end