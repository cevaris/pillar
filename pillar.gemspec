# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pillar/version'

Gem::Specification.new do |spec|
  spec.name          = "pillar"
  spec.version       = Pillar::VERSION
  spec.authors       = ["Adam Cardenas"]
  spec.email         = ["cevaris@gmail.com"]
  spec.summary       = %q{Highly reliable, distributed process management.}
  spec.description   = %q{Highly reliable, distributed process management.}
  spec.homepage      = "https://github.com/cevaris/pillar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  
  spec.add_development_dependency 'etcd'
  spec.add_development_dependency 'sinatra'
  spec.add_development_dependency 'pidfile'
  spec.add_development_dependency 'listen'
end
