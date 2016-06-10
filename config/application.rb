require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require "pp"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodeaTAG
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'twitter_secrets.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end

# Aquí es donde vamos a pegar el TwitterClient 
CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = Rails.application.secrets.consumer_key
  config.consumer_secret     = Rails.application.secrets.consumer_secret
  config.access_token        = Rails.application.secrets.access_token
  config.access_token_secret = Rails.application.secrets.access_token_secret
end