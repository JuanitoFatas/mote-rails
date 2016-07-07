# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mote/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "mote-rails"
  spec.version       = Mote::Rails::VERSION
  spec.authors       = ["JuanitoFatas"]
  spec.email         = ["katehuang0320@gmail.com"]

  spec.summary       = %q(Mote templates generator for Rails 3+)
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/JuanitoFatas/mote-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mote", ">= 1"
  spec.add_dependency "actionpack", ">= 4.0.1"
  spec.add_dependency "railties", ">= 4.0.1"
end
