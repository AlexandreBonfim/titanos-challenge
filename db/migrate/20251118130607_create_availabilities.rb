class CreateAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :availabilities do |t|
      t.references :app, null: false, foreign_key: true
      t.references :available, polymorphic: true, null: false
      t.string :market, null: false
      t.jsonb :stream_info, null: false, default: {}

      t.timestamps
    end

    add_index :availabilities, [ :market ]
    add_index :availabilities, [ :app_id, :market ]
  end
end
