# frozen_string_literal: true

# require 'acts_as_tenant/sidekiq'
ActsAsTenant.configure do |config|
  # config.require_tenant = true
  config.require_tenant = lambda do
    if ENV.fetch("DISABLE_REQUIRE_TENANT", false) ||
       ($request_env.present? && $request_env["REQUEST_PATH"].start_with?("/admin/"))
      return false
    end

    true
  end
end
