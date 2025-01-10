class CreateMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid, index: true
      t.references :user, null: false, foreign_key: true, type: :uuid, index: false
      t.string :role, null: false, default: 'owner'
      t.jsonb :preferences

      t.timestamps
    end
    add_index :memberships, %i[user_id team_id], unique: true
  end
end
