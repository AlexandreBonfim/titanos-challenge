# == Schema Information
#
# Table name: channel_programs
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string           not null
#  schedule            :jsonb            not null
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  channel_id          :bigint           not null
#
# Indexes
#
#  index_channel_programs_on_channel_id      (channel_id)
#  index_channel_programs_on_original_title  (original_title)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
class ChannelProgram < ApplicationRecord
  include Searchable

  belongs_to :channel
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true

  scope :available_in, ->(market) {
    joins(:availabilities)
      .merge(Availability.for_market(market))
      .distinct
  }
end
