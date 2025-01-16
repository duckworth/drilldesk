class CreatePredefinedScenarios < ActiveRecord::Migration[8.0]
  def change
    create_table :predefined_scenarios, id: :uuid do |t|
      t.string :name
      t.text :description
      t.boolean :enabled, null: false, default: true
      t.references :exercise_type, null: false, foreign_key: true, type: :uuid
      t.references :starting_scenario_event, null: false, foreign_key: { to_table: :predefined_events }, type: :uuid

      t.timestamps
    end
  end
end
