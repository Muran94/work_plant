require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.load_path += Dir.glob(Rails.root.join("config", "locales", "**", "*.{rb,yml}"))
    config.i18n.default_locale = :ja
    config.time_zone = "Asia/Tokyo"
    config.paths.add 'lib', eager_load: true
    config.active_job.queue_adapter = :sidekiq

    config.generators do |g|
      g.assets false
      g.helpers false
      g.skip_routes false
      g.test_framework :rspec,
        controller_specs: false,
        fixtures:         false,
        helper_specs:     false,
        model_specs:      true,
        request_spec:     true,
        routing_specs:    false,
        view_specs:       false
    end
  end
end
