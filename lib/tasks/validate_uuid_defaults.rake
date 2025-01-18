namespace :db do
  desc "Validate that all UUID primary keys use uuid_generate_v8() as the default"
  task validate_uuid_defaults: :environment do
    invalid_tables = []

    ActiveRecord::Base.connection.tables.each do |table|
      pk = ActiveRecord::Base.connection.primary_key(table)
      next unless pk == "id"

      column = ActiveRecord::Base.connection.columns(table).find { |col| col.name == "id" }
      next unless column.sql_type == "uuid"

      default_function = column.default_function
      unless default_function&.include?("uuid_generate_v8()")
        invalid_tables << table
      end
    end

    if invalid_tables.any?
      raise "The following tables have UUID primary keys without the correct default function:\n#{invalid_tables.join("\n")}"
    else
      puts "All UUID primary keys have the correct default function."
    end
  end
end
