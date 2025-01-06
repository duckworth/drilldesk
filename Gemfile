source "https://rubygems.org"

gem "rails", "~> 8.0.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "letter_opener"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

# Addons
gem "devise"
gem "show_for"
gem "friendly_id"
gem "has_scope"
gem "pagy"
gem "dotenv", groups: [ :development, :test ]
gem "activeadmin", ">= 4.0.0.beta15"
gem "local_time"
gem "truemail"
gem "flipper"
gem "flipper-active_record"
gem "flipper-ui"
gem "mission_control-jobs"
gem "active_model_validates_intersection_of"
gem "rubyzip"
