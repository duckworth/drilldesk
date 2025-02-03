class InitialDatabaseSetup < ActiveRecord::Migration[8.0]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS vector;"
    enable_extension 'vector'

    execute <<-SQL
      -- v8 with microsecond precision from https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
      -- Generate a custom UUID v8 with microsecond precision
      create or replace function uuid_generate_v8()
      returns uuid
      as $$
      declare
        timestamp    timestamptz;
        microseconds int;
      begin
        timestamp    = clock_timestamp();
        microseconds = (cast(extract(microseconds from timestamp)::int - (floor(extract(milliseconds from timestamp))::int * 1000) as double precision) * 4.096)::int;

        -- use random v4 uuid as starting point (which has the same variant we need)
        -- then overlay timestamp
        -- then set version 8 and add microseconds
        return encode(
          set_byte(
            set_byte(
              overlay(uuid_send(gen_random_uuid())
                      placing substring(int8send(floor(extract(epoch from timestamp) * 1000)::bigint) from 3)
                      from 1 for 6
              ),
              6, (b'1000' || (microseconds >> 8)::bit(4))::bit(8)::int
            ),
            7, microseconds::bit(8)::int
          ),
          'hex')::uuid;
      end
      $$
      language plpgsql
      volatile;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS uuid_generate_v8();
    SQL

    disable_extension 'vector'
  end
end
