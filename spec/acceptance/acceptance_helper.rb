require 'rails_helper'

OmniAuth.config.test_mode = true
OmniAuth.config.logger = Rails.logger

RSpec.configure do |config|

  Capybara.javascript_driver = :webkit
  
  # Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.use_transactional_fixtures = false

  config.include AcceptanceHelper, type: :feature
  config.include OmniauthMacros
end