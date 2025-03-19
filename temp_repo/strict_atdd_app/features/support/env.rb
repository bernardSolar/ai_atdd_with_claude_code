require 'cucumber'
require 'rspec/expectations'
require 'capybara/cucumber'
require 'rack/test'

# Set the environment to test
ENV['RACK_ENV'] = 'test'

# Will load app.rb later after creating it
require_relative '../../app'

# Define the app for testing
module AppHelper
  def app
    Sinatra::Application
  end
end

# Configure Capybara
Capybara.app = Sinatra::Application

# Include modules in the World
World(Rack::Test::Methods, AppHelper, Capybara::DSL)