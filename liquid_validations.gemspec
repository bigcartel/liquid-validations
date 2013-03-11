# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liquid_validations/version'

Gem::Specification.new do |gem|
  gem.name          = 'liquid_validations'
  gem.version       = LiquidValidations::VERSION
  gem.authors       = ['Joshua Abbott']
  gem.email         = ['josh@bigcartel.com']
  gem.description   = %q{ ActiveRecord style validations for Liquid content in your ActiveRecord models. See the README for the lowdown. }
  gem.summary       = %q{ ActiveRecord style validations for Liquid content in your ActiveRecord models. }
  gem.homepage      = 'https://github.com/bigcartel/liquid_validations'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'liquid'
  gem.add_dependency 'activerecord'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'sqlite3'
end
