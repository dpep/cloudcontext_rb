require 'byebug'
require 'faraday'
require 'ice_age'
require 'rack/test'
require 'rails'
require 'rspec'
require 'rspec/matchers/fail_matchers'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

if ENV['CI'] == 'true' || ENV['CODECOV_TOKEN']
  require 'simplecov_json_formatter'
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
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

  config.before { CloudContext::RSpec.enable }
end

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
