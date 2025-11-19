class CreateFavoriteApps < ActiveRecord::Migration[8.0]
  def change
    create_table :favorite_apps do |t|
      t.integer :user_id, null: false
      t.references :app, null: false, foreign_key: true
      t.integer :position, null: false

      t.timestamps
    end

    add_index :favorite_apps, [ :user_id, :app_id ], unique: true
    add_index :favorite_apps, [ :user_id, :position ]
  end
end
