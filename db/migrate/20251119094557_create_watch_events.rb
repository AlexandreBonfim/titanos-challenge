class CreateWatchEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :watch_events do |t|
      t.integer :user_id, null: false
      t.references :channel_program, null: false, foreign_key: true
      t.integer :watched_seconds, null: false, default: 0

      t.timestamps
    end

    add_index :watch_events, [ :user_id, :channel_program_id ], unique: true
  end
end
