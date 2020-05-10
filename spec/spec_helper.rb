require 'bundler/setup'
require 'as_range'

RSpec.configure do |config|
  # Run tests in random order.
  config.order = 'random'

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Ignore focus tag on CI environments.
  config.filter_run_when_matching focus: true if ENV['CI'].blank?
end
