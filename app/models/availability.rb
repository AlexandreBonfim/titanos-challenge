# == Schema Information
#
# Table name: availabilities
#
#  id             :bigint           not null, primary key
#  available_type :string           not null
#  market         :string           not null
#  stream_info    :jsonb            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  app_id         :bigint           not null
#  available_id   :bigint           not null
#
# Indexes
#
#  index_availabilities_on_app_id             (app_id)
#  index_availabilities_on_app_id_and_market  (app_id,market)
#  index_availabilities_on_available          (available_type,available_id)
#  index_availabilities_on_market             (market)
#
# Foreign Keys
#
#  fk_rails_...  (app_id => apps.id)
#
class Availability < ApplicationRecord
  belongs_to :app
  belongs_to :available, polymorphic: true

  validates :market, presence: true

  scope :for_market, ->(market) { where(market: market) }
end
