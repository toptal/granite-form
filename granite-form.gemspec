require File.expand_path('../lib/granite/form/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ['Toptal Engineering']
  gem.description = 'Making object from any hash or hash array'
  gem.summary = 'Working with hashes in AR style'
  gem.homepage = 'https://github.com/toptal/granite-form'

  gem.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = 'granite-form'
  gem.require_paths = ['lib']
  gem.required_ruby_version = '>= 2.4.0'
  gem.version = Granite::Form::VERSION

  gem.add_development_dependency 'actionpack', '>= 5.0'
  gem.add_development_dependency 'activerecord', '>= 5.0'
  gem.add_development_dependency 'appraisal'
  gem.add_development_dependency 'bump'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'pg'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.7.0'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'rubocop', '0.52.1'
  gem.add_development_dependency 'uuidtools'

  gem.add_runtime_dependency 'activemodel', '>= 5.0'
  gem.add_runtime_dependency 'activesupport', '>= 5.0'
  gem.add_runtime_dependency 'tzinfo'
end
