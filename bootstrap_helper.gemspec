# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bootstrap_helper/version'

Gem::Specification.new do |spec|
  spec.name          = "bootstrap_helper"
  spec.version       = BootstrapHelper::VERSION
  spec.authors       = ["Stephan Zalewski"]
  spec.email         = ["stephan@foo-labs.com"]
  spec.description   = %q{bootstrap helper}
  spec.summary       = %q{bootstrap helper}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
