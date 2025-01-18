require_relative "../lib/utils"
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Drilldesk
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    config.app_settings = config_for(:app_settings)

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_record.schema_format = :sql
    config.mission_control.jobs.http_basic_auth_enabled = false


    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.test_framework :test_unit, spec: false, fixture_replacement: :fabrication
      g.fixture_replacement :fabrication, dir: "test/fabricators"
      g.jbuilder false
    end
    config.app_generators.scaffold_controller = :scaffold_controller
    config.after_initialize do
      ActionView::Base.default_form_builder = TailwindFormBuilder
    end
  end
end
