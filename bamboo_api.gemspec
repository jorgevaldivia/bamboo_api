# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bamboo_api/version'

Gem::Specification.new do |gem|
  gem.name          = "bamboo_api"
  gem.version       = BambooApi::VERSION
  gem.authors       = ["Jorge Valdivia"]
  gem.email         = ["jorge@valdivia.me"]
  gem.description   = %q{Atlassian Bamboo API Wrapper}
  gem.summary       = %q{A simple wrapper for Atlassian's Bamboo's REST API.}
  gem.homepage      = "https://github.com/jorgevaldivia/bamboo_api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "multi_json"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "webmock"
  gem.add_runtime_dependency "rest-client"

end
