FactoryBot.define do
  factory :content_item do
    association :searchable, factory: :movie
    original_title { "MyString" }
    year { 1 }
  end
end
