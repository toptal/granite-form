require 'bundler'
require 'pry'
Bundler.require

require 'rspec/its'
require 'active_record'
require 'rack/test'
require 'action_controller/metal/strong_parameters'
require 'database_cleaner'

Dir[File.join(__dir__, 'support', '**', '*.rb')].sort.each { |f| require f }

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
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
