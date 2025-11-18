class Channel < ApplicationRecord
  has_many :channel_programs, dependent: :destroy
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true
end
