class TvShow < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :episodes, dependent: :destroy
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true
end
