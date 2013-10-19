# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Jogger3::Application.initialize!

Jogger3::Application.configure do
  config.autoload_paths += %W(#{Rails.root}/app/services)
  #config.load_path += %W(#{Rails.root}/app/services)
end