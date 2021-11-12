require 'byebug'
require 'ice_age'
require 'rspec'
require 'simplecov'
require 'rack/test'
require 'rails'
require 'rspec/matchers/fail_matchers'

SimpleCov.start do
  add_filter /spec/
end

if ENV['CI'] == 'true' || ENV['CODECOV_TOKEN']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

# load this gem
gem_name = Dir.glob('*.gemspec')[0].split('.')[0]
require gem_name

RSpec.configure do |config|
  # allow 'fit' examples
  config.filter_run_when_matching :focus

  config.mock_with :rspec do |mocks|
    # verify existence of stubbed methods
    mocks.verify_partial_doubles = true
  end

  include Rack::Test::Methods
  include RSpec::Matchers::FailMatchers
end

# Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
