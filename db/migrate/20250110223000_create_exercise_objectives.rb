class CreateExerciseObjectives < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_objectives, id: :bigint do |t|
      t.string :name
      t.text :description
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end
  end
end
