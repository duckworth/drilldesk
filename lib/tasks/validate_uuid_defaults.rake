namespace :db do
  desc "Validate that all UUID primary keys use uuid_generate_v8() as the default"
  task validate_uuid_defaults: :environment do
    begin
      result = DB::UUIDDefaultValidator.validate!
      puts result
    rescue => e
      raise e.message
    end
  end
end
