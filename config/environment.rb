# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Domased::Application.initialize!

config.gem 'redis'
