class CreateChannelPrograms < ActiveRecord::Migration[8.0]
  def change
    create_table :channel_programs do |t|
      t.references :channel, null: false, foreign_key: true
      t.string :original_title, null: false
      t.integer :year
      t.integer :duration_in_seconds
      t.jsonb :schedule, null: false, default: []

      t.timestamps
    end

    add_index :channel_programs, :original_title
  end
end
