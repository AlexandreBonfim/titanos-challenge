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
require "rails_helper"

RSpec.describe Availability, type: :model do
  it "is valid with app, market and available content" do
    app = App.create!(name: "netflix")
    movie = Movie.create!(original_title: "Test", year: 2024, duration_in_seconds: 3600)

    availability = described_class.new(
      app: app,
      available: movie,
      market: "gb"
    )

    expect(availability).to be_valid
  end

  it "requires a market" do
    app = App.create!(name: "netflix")
    movie = Movie.create!(original_title: "Test", year: 2024, duration_in_seconds: 3600)

    availability = described_class.new(app: app, available: movie, market: nil)

    expect(availability).not_to be_valid
    expect(availability.errors[:market]).to be_present
  end
end
