class CreateCustomScenarios < ActiveRecord::Migration[8.0]
  def change
    create_table :custom_scenarios, id: :uuid, default: 'uuid_generate_v8()' do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.text :description
      t.string :status, null: false, default: :draft
      t.references :exercise_type, null: false, foreign_key: true, type: :bigint
      t.text :source_text
      t.references :created_by, null: true, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
