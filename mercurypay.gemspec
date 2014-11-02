# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mercurypay/version'

Gem::Specification.new do |spec|
  spec.name          = "mercurypay"
  spec.version       = Mercurypay::VERSION
  spec.authors       = ["Yehia Abo El-Nga"]
  spec.email         = ["yhia.yasser@gmail.com"]
  spec.description   = %q{This is a wrapper for Mercury Payments REST API}
  spec.summary       = %q{This is a wrapper for Mercury Payments REST API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "httparty"
end
