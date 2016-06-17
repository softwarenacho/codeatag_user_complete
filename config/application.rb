require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "pp"

Bundler.require(*Rails.groups)

# Este modulo se encarga de interpretar el archivo que contiene tus tokens
# y agregarlos como variables de entorno para tu aplicación.
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

# Este código crea un cliente de Twitter con los tokens que nos fueron asignados
CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = Rails.application.secrets.consumer_key
  config.consumer_secret     = Rails.application.secrets.consumer_secret
  config.access_token        = Rails.application.secrets.access_token
  config.access_token_secret = Rails.application.secrets.access_token_secret
end