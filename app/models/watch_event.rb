class WatchEvent < ApplicationRecord
  belongs_to :channel_program

  validates :user_id, presence: true
  validates :watched_seconds, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, uniqueness: { scope: :channel_program_id }
end
