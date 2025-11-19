FactoryBot.define do
  factory :watch_event do
    user_id { 1 }
    channel_program { nil }
    watched_seconds { 1 }
  end
end
