require 'bundler'
require 'pry'
Bundler.require

require 'rspec/its'
require 'active_record'
require 'rack/test'
require 'action_controller/metal/strong_parameters'
require 'database_cleaner'

Dir[File.join(__dir__, 'support', '**', '*.rb')].sort.each { |f| require f }

# Opt in to the latest to_time behavior to silence deprecation warnings.
# Rails 7.2: expects `true`, Rails 8.0: expects `:zone`, Rails 8.1+: default is correct.
if Gem::Version.new(ActiveSupport::VERSION::STRING) < Gem::Version.new('8.1') && ActiveSupport.respond_to?(:to_time_preserves_timezone=)
  ActiveSupport.to_time_preserves_timezone = :zone
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :random
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true

  config.include ModelHelpers
  config.include MuffleHelpers

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
    Granite::Form.logger = Logger.new('/dev/null')
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
