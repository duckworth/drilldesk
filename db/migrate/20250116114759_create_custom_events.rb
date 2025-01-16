class CreateCustomEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :custom_events, id: :uuid do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.text :description
      t.references :custom_scenario, null: false, foreign_key: true, type: :uuid
      t.jsonb :trigger_keywords
      t.integer :sequence_order, null: false, default: 0

      t.timestamps
    end
  end
end
