class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :status, null: false, default: :active
      t.boolean :is_test, null: false, default: false
      t.string :timezone, null: false, default: 'America/New_York'
      t.datetime :disabled_at
      t.datetime :suspended_at
      t.timestamps
      t.index :slug, unique: true
    end
  end
end
