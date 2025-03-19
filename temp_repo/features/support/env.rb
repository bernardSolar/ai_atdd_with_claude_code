require 'cucumber'
require 'rack/test'
require 'rspec/expectations'
require 'capybara/cucumber'

# Set the environment to test
ENV['RACK_ENV'] = 'test'

# We need to make sure the app is loaded after setting the environment
require_relative '../../app'

module AppHelper
  def app
    Sinatra::Application
  end
end

# Configure Capybara for testing
Capybara.app = Sinatra::Application
Capybara.server = :webrick
Capybara.default_driver = :rack_test

# Reset the appointment manager before each scenario
Before do
  Sinatra::Application.settings.appointment_manager = AppointmentManager.new
end

World(Rack::Test::Methods, AppHelper, Capybara::DSL)
