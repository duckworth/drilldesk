if Rails.env.development? && !Utils.env_bool("SKIP_CHECKS")
  require_dependency Rails.root.join("app/lib/db/uuid_default_validator").to_s

  Rails.application.config.after_initialize do
    puts DB::UUIDDefaultValidator.validate!
  end
end
