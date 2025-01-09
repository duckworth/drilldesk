
# https://github.com/heartcombo/devise/pull/5728
if Rails.env.local?
  require "devise"
  Devise # ensure it’s loaded to modify

  module Devise
    def self.mappings
      # Reload routes if necessary to ensure mappings are built properly
      Rails.application.try(:reload_routes_unless_loaded)
      @@mappings
    end
  end
end
