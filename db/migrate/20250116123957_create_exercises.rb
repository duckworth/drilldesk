class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises, id: :uuid do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.text :purpose
      t.string :status, null: false, default: :not_started
      t.references :exercise_type, null: false, foreign_key: true, type: :bigint
      t.references :custom_scenario, null: true, foreign_key: true, type: :uuid
      t.references :predefined_scenario, null: true, foreign_key: true, type: :uuid
      t.datetime :exercise_date
      t.jsonb :context_data
      t.references :owner, null: true, foreign_key: { to_table: :users }, type: :uuid
      t.datetime :in_progress_at
      t.datetime  :exercised_at
      t.datetime  :retrospecting_at
      t.datetime  :retrospected_at

      t.timestamps
    end
  end
end
