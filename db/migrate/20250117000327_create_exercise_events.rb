class CreateExerciseEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_events, id: :uuid, default: 'uuid_generate_v8()' do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.references :exercise, null: false, foreign_key: true, type: :uuid
      t.string :event_type
      t.uuid :event_id
      t.datetime :triggered_at
      t.string :status, null: false, default: :pending
      t.bigint :relative_event_time

      t.timestamps
      t.index [ :event_type, :event_id ]
    end
  end
end
