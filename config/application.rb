require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UsdRubExchangeRate
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :sidekiq
    config.time_zone = 'Moscow'
    config.action_cable.disable_request_forgery_protection = false
  end
end
