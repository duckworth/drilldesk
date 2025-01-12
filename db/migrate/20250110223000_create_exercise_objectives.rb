class CreateExerciseObjectives < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_objectives, id: :bigint do |t|
      t.string :name
      t.text :description
      t.boolean :enabled

      t.timestamps
    end
  end
end
