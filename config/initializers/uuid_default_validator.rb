if Rails.env.development? && !Utils.env_bool("SKIP_CHECKS")
  Rails.application.config.after_initialize do
    # until Postgres native UUID v7/v8 is available, check we are using custom UUID v8
    Rails.application.load_tasks # Load all defined tasks
    Rake::Task["db:validate_uuid_defaults"].invoke
  end
end
