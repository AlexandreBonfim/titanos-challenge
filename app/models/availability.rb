class Availability < ApplicationRecord
  belongs_to :app
  belongs_to :available, polymorphic: true

  validates :market, presence: true
end
