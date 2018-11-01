require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vaquita
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += Dir.glob("#{Rails.root}/app/services/*")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_mailer.default_url_options = { host: Settings.vaquita.host }

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: Settings.mail.smtp_address || 'smtp.gmail.com',
      port: Settings.mail.smtp_port || 587,
    }

    config.time_zone = Settings.vaquita.time_zone
  end
end
