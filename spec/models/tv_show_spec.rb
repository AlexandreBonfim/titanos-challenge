# == Schema Information
#
# Table name: tv_shows
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "rails_helper"

RSpec.describe TvShow, type: :model do
  it "is valid with title and year" do
    tv = described_class.new(original_title: "Demon Slayer", year: 2019)
    expect(tv).to be_valid
  end

  it "has many seasons and episodes" do
    tv = TvShow.create!(original_title: "Demon Slayer", year: 2019)
    season = Season.create!(tv_show: tv, original_title: "S1", number: 1, year: 2019)
    episode = Episode.create!(
      tv_show: tv,
      season: season,
      original_title: "Ep1",
      number: 1,
      year: 2019,
      duration_in_seconds: 1800
    )

    expect(tv.seasons).to include(season)
    expect(tv.episodes).to include(episode)
  end
end
