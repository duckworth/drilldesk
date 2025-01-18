class CreateExerciseArtifacts < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_artifacts, id: :uuid, default: 'uuid_generate_v8()' do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.references :exercise, null: false, foreign_key: true, type: :uuid
      t.integer :artifact_type

      t.timestamps
    end
  end
end
