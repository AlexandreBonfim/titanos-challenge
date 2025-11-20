# == Schema Information
#
# Table name: channels
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Channel < ApplicationRecord
  include Searchable

  has_many :channel_programs, dependent: :destroy
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true

  scope :available_in, ->(market) {
    joins(:availabilities)
      .merge(Availability.for_market(market))
      .distinct
  }
end
