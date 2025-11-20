class App < ApplicationRecord
  has_many :availabilities, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :available_in, ->(market) {
    joins(:availabilities)
      .merge(Availability.for_market(market))
      .distinct
  }
end
