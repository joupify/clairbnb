require_relative "boot"

require "rails/all"
require 'dotenv/load'
require_relative '../app/uploaders/image_uploader'



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Clairbnb
  class Application < Rails::Application
    config.autoload_paths << "#{root}/app/views"
    config.autoload_paths << "#{root}/app/views/layouts"
    config.autoload_paths << "#{root}/app/views/components"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    Rails.application.default_url_options = {host: 'localhost', port: 3000}
    config.active_job.queue_adapter = :resque
    
    # Allow requests from any host - testing search
    config.hosts.clear






    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
