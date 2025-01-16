class CreateExerciseObjectiveAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_objective_assignments, id: :uuid do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.references :exercise, null: false, foreign_key: true, type: :uuid
      t.references :exercise_objective, null: false, foreign_key: true, type: :bigint
      t.integer :priority

      t.timestamps
    end
  end
end
