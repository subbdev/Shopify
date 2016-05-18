require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/email/rspec'
require 'capybara-screenshot/rspec'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

Capybara.default_wait_time = 10
