# == Schema Information
#
# Table name: channel_programs
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string           not null
#  schedule            :jsonb            not null
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  channel_id          :bigint           not null
#
# Indexes
#
#  index_channel_programs_on_channel_id      (channel_id)
#  index_channel_programs_on_original_title  (original_title)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
FactoryBot.define do
  factory :channel_program do
    channel { nil }
    original_title { "MyString" }
    year { 1 }
    duration_in_seconds { 1 }
    schedule { "" }
  end
end
