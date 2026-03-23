require File.expand_path('../lib/granite/form/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ['Toptal Engineering']
  gem.description = 'Making object from any hash or hash array'
  gem.summary = 'Working with hashes in AR style'
  gem.homepage = 'https://github.com/toptal/granite-form'

  gem.files = ['lib/**/*.rb']
  gem.name = 'granite-form'
  gem.require_paths = ['lib']
  gem.required_ruby_version = '>= 3.3'
  gem.version = Granite::Form::VERSION

  gem.add_development_dependency 'actionpack', '>= 7.2'
  gem.add_development_dependency 'activerecord', '>= 7.2'
  gem.add_development_dependency 'bump'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'pg'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.7.0'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'rubocop', '1.63.5'
  gem.add_development_dependency 'rubocop-rspec', '2.29.2'
  gem.add_development_dependency 'uuidtools'

  gem.add_runtime_dependency 'activemodel', '>= 7.2'
  gem.add_runtime_dependency 'activesupport', '>= 7.2'
  gem.add_runtime_dependency 'tzinfo'
end
