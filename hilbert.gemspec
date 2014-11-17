# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hilbert/version'

Gem::Specification.new do |spec|
  spec.name          = 'hilbert'
  spec.version       = Hilbert::VERSION
  spec.authors       = ['gogotanaka']
  spec.email         = ['mail@tanakakazuki.com']
  spec.extensions    = ['ext/hilbert/extconf.rb']
  spec.summary       = %q{Enjoy MATH!}
  spec.description   = %q{Enjoy MATH!}
  spec.homepage      = 'http://q-language.org/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'dydx', '~> 0.2.7000001'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rake-compiler'
  spec.add_development_dependency 'minitest'
end
