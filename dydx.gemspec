# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dydx/version'

Gem::Specification.new do |spec|
  spec.name          = "dydx"
  spec.version       = Dydx::VERSION
  spec.authors       = ["gogotanaka"]
  spec.email         = ["qlli.illb@gmail.com"]
  spec.homepage      = "https://github.com/gogotanaka"
  spec.summary       = %q{We can enjoy the derivative.}
  spec.description   = %q{It is possible to use the differential using the Symbol and Fixnum by including the Dydx. And, we can use the natural logarithm and log.}

  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
