FactoryBot.define do
  factory :episode do
    tv_show { nil }
    season { nil }
    original_title { "MyString" }
    number { 1 }
    year { 1 }
    duration_in_seconds { 1 }
  end
end
