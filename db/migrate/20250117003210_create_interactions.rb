class CreateInteractions < ActiveRecord::Migration[8.0]
  def change
    create_table :interactions, id: :uuid, default: 'uuid_generate_v8()' do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.references :exercise, null: false, foreign_key: true, type: :uuid
      t.references :exercise_event, null: false, foreign_key: true, type: :uuid
      t.integer :interaction_type
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.jsonb :user_input
      t.jsonb :ai_response
      t.decimal :response_confidence, precision: 8, scale: 6

      t.timestamps
    end
  end
end
