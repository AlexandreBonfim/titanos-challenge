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
class WatchEvent < ApplicationRecord
  belongs_to :channel_program

  validates :user_id, presence: true
  validates :watched_seconds, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, uniqueness: { scope: :channel_program_id }
end
