class TvShow < ApplicationRecord
  include Searchable

  has_many :seasons, dependent: :destroy
  has_many :episodes, dependent: :destroy
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true

  scope :available_in, ->(market) {
    joins(:availabilities)
      .merge(Availability.for_market(market))
      .distinct
  }
end
