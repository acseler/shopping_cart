# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'database_cleaner'
require 'factory_girl_rails'
require 'shoulda/matchers'
require 'ffaker'
require 'support/feature'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/webkit/matchers'
ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  include FeatureHelper

  config.include AbstractController::Translation
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  config.include Rails.application.routes.url_helpers
  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
end
