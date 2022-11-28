require File.expand_path('../lib/granite/form/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['pyromaniac']
  gem.email         = ['kinwizard@gmail.com']
  gem.description   = 'Making object from any hash or hash array'
  gem.summary       = 'Working with hashes in AR style'
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'granite-form'
  gem.require_paths = ['lib']
  gem.version       = Granite::Form::VERSION

  gem.add_development_dependency 'actionpack', '>= 4.0'
  gem.add_development_dependency 'activerecord', '>= 4.0'
  gem.add_development_dependency 'appraisal'
  gem.add_development_dependency 'bump'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.7.0'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'rubocop', '0.52.1'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'uuidtools'

  gem.add_runtime_dependency 'activemodel', '>= 4.0'
  gem.add_runtime_dependency 'activesupport', '>= 4.0'
  gem.add_runtime_dependency 'tzinfo'
end
