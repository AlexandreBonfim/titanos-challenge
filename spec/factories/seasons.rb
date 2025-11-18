FactoryBot.define do
  factory :season do
    tv_show { nil }
    original_title { "MyString" }
    number { 1 }
    year { 1 }
    duration_in_seconds { 1 }
  end
end
