class CreateTvShows < ActiveRecord::Migration[8.0]
  def change
    create_table :tv_shows do |t|
      t.string :original_title
      t.integer :year
      t.integer :duration_in_seconds

      t.timestamps
    end
  end
end
