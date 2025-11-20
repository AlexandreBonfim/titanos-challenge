class Episode < ApplicationRecord
  belongs_to :tv_show
  belongs_to :season
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true
  validates :number, presence: true

  scope :available_in, ->(market) {
    joins(season: :availabilities)
      .merge(Availability.for_market(market))
      .distinct
  }
end
