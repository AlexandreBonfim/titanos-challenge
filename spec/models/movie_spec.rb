require "rails_helper"

RSpec.describe Movie, type: :model do
  it "is valid with title, year and duration" do
    movie = described_class.new(
      original_title: "Star Wars",
      year: 1980,
      duration_in_seconds: 7200
    )

    expect(movie).to be_valid
  end

  it "has many availabilities" do
    app = App.create!(name: "netflix")
    movie = Movie.create!(original_title: "Star Wars", year: 1980, duration_in_seconds: 7200)
    Availability.create!(app: app, available: movie, market: "gb")

    expect(movie.availabilities.count).to eq(1)
  end
end
