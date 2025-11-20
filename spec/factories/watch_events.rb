# == Schema Information
#
# Table name: watch_events
#
#  id                 :bigint           not null, primary key
#  watched_seconds    :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  channel_program_id :bigint           not null
#  user_id            :integer          not null
#
# Indexes
#
#  index_watch_events_on_channel_program_id              (channel_program_id)
#  index_watch_events_on_user_id_and_channel_program_id  (user_id,channel_program_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (channel_program_id => channel_programs.id)
#
FactoryBot.define do
  factory :watch_event do
    user_id { 1 }
    channel_program { nil }
    watched_seconds { 1 }
  end
end
