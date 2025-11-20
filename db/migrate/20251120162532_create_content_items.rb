class CreateContentItems < ActiveRecord::Migration[8.0]
  def change
    create_table :content_items do |t|
      t.references :searchable, polymorphic: true, null: false
      t.string :original_title
      t.integer :year

      t.timestamps
    end
  end
end
