# == Schema Information
#
# Table name: seasons
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  number              :integer
#  original_title      :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tv_show_id          :bigint           not null
#
# Indexes
#
#  index_seasons_on_tv_show_id  (tv_show_id)
#
# Foreign Keys
#
#  fk_rails_...  (tv_show_id => tv_shows.id)
#
class Season < ApplicationRecord
  include Searchable

  belongs_to :tv_show
  has_many :episodes, dependent: :destroy
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true
  validates :number, presence: true

  scope :available_in, ->(market) {
    joins(:availabilities)
      .merge(Availability.for_market(market))
      .distinct
  }
end
