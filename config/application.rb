require File.expand_path('../boot', __FILE__)

require File.expand_path('../webistrano_config', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Webistrano
  class Application < Rails::Application
    config.autoload_paths += [config.root.join('lib')]
    config.encoding = 'utf-8'
  
    # Your secret key for verifying cookie session data integrity.
    # If you change this key, all old sessions will become invalid!
    # Make sure the secret is at least 30 characters and all random, 
    # no regular words or you'll be exposed to dictionary attacks.
    #config.action_controller.session = {
    #  :key    => '_webistrano_session',
    #  :secret => WebistranoConfig[:session_secret]
    #}
  
    # Make Active Record use UTC-base instead of local time
    config.time_zone = 'UTC'
    
    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
