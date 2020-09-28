require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module RailsBaseApi
  class Application < Rails::Application
    config.load_defaults 6.0

    config.api_only = true

    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths += ["#{Rails.root}/lib/api"]

    config.time_zone = "Asia/Tokyo"

    config.active_record.default_timezone = :utc

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, :post, :options]
      end
    end

    config.middleware.use Rack::Attack

    config.i18n.default_locale = :ja

    config.paths.add "app/serializers/concerns", eager_load: true
  end
end
