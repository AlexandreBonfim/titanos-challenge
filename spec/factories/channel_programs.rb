FactoryBot.define do
  factory :channel_program do
    channel { nil }
    original_title { "MyString" }
    year { 1 }
    duration_in_seconds { 1 }
    schedule { "" }
  end
end
