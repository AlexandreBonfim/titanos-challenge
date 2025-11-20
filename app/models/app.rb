# == Schema Information
#
# Table name: apps
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_apps_on_name  (name) UNIQUE
#
class App < ApplicationRecord
  has_many :availabilities, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :available_in, ->(market) {
    joins(:availabilities)
      .merge(Availability.for_market(market))
      .distinct
  }
end
