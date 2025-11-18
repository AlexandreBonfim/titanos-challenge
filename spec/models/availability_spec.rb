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
