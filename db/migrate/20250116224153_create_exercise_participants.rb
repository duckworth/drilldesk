class CreateExerciseParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_participants, id: :uuid, default: 'uuid_generate_v8()' do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.references :exercise, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.string :role, null: false

      t.timestamps
    end
  end
end
