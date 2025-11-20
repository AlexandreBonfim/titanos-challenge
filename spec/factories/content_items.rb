# == Schema Information
#
# Table name: content_items
#
#  id              :bigint           not null, primary key
#  original_title  :string
#  searchable_type :string           not null
#  year            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  searchable_id   :bigint           not null
#
# Indexes
#
#  index_content_items_on_searchable  (searchable_type,searchable_id)
#
FactoryBot.define do
  factory :content_item do
    association :searchable, factory: :movie
    original_title { "MyString" }
    year { 1 }
  end
end
