class CreatePredefinedScenarios < ActiveRecord::Migration[8.0]
  def change
    create_table :predefined_scenarios, id: :uuid, default: 'uuid_generate_v8()' do |t|
      t.string :name
      t.text :description
      t.boolean :enabled, null: false, default: true
      t.references :exercise_type, null: false, foreign_key: true, type: :bigint
      # moved circular reference to separate migration
      # t.references :starting_scenario_event, null: true, foreign_key: { to_table: :predefined_events, deferrable: :deferredi }, type: :uuid

      t.timestamps
    end
  end
end
