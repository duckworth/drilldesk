class CreatePredefinedEventTransitions < ActiveRecord::Migration[8.0]
  def change
    create_table :predefined_event_transitions, id: :uuid do |t|
      t.references :from_event, null: false, foreign_key: { to_table: :predefined_events }, type: :uuid
      t.references :to_event, null: false, foreign_key: { to_table: :predefined_events }, type: :uuid
      t.jsonb :condition, null: false, default: {}

      t.timestamps
    end
  end
end
