class Movie < ApplicationRecord
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true
end
