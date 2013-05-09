# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prevent_remote_requests/version'

Gem::Specification.new do |spec|
  spec.name          = "prevent_remote_requests"
  spec.version       = PreventRemoteRequests::VERSION
  spec.authors       = ["Christopher Maujean"]
  spec.email         = ["cmaujean@pincsolutions.com"]
  spec.description   = %q{Rack Middleware for rejecting all remote requests}
  spec.summary       = %q{reject remote requests to your rack based application}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack"
  spec.add_development_dependency "rack-test"
end
