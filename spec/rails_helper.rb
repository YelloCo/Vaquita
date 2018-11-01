require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

if ActiveRecord::Migrator.needs_migration?
  ActiveRecord::Migrator.migrate(Rails.root.join('db', 'migrate'))
end
ActiveRecord::Migration.maintain_test_schema!
DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Warden::Test::Helpers
  config.include FactoryBot::Syntax::Methods

  config.before(:each) { DatabaseCleaner.clean }
  config.after(:each) { DeltaScheduler.cancel_all }
end

Capybara.register_driver(:headless_chrome) do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[window-size=1920,1080]
  )
  options.headless!

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end
Capybara.javascript_driver = :headless_chrome
