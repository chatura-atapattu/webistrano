if WebistranoConfig[:authentication_method] == :cas
  cas_options = YAML::load_file(RAILS_ROOT+'/config/cas.yml')
  Devise.config.cas_base_url = cas_options.cas_base_url
  # Devise.config.cas_login_url = cas_options.cas_login_url
  # Devise.config.cas_logout_url = cas_options.cas_logout_url
  # Devise.config.cas_validate_url = cas_options.cas_validate_url
  # Devise.config.cas_destination_url = cas_options.cas_destination_url
  # Devise.config.cas_follow_url = cas_options.cas_follow_url
  # Devise.config.cas_logout_url_param = cas_options.cas_logout_url_param
  # Devise.config.cas_create_user = cas_options.cas_create_user
end

WEBISTRANO_VERSION = '1.5'

ActionMailer::Base.delivery_method = WebistranoConfig[:smtp_delivery_method] 
ActionMailer::Base.smtp_settings = WebistranoConfig[:smtp_settings] 

Notification.webistrano_sender_address = WebistranoConfig[:webistrano_sender_address]

Webistrano::Application.config.middleware.use ExceptionNotifier,
  :sender_address => WebistranoConfig[:exception_sender_address],
  :exception_recipients => WebistranoConfig[:exception_recipients]
