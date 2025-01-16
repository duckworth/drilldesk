class CreatePredefinedEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :predefined_events, id: :uuid do |t|
      t.string :name
      t.text :description
      t.references :predefined_scenario, null: false, foreign_key: true, type: :uuid
      t.jsonb :trigger_conditions, null: false, default: {}

      t.timestamps
    end
  end
end
