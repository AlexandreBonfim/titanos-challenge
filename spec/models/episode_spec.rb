require "rails_helper"

RSpec.describe Episode, type: :model do
  it "belongs to a tv_show and a season" do
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

    expect(episode.tv_show).to eq(tv)
    expect(episode.season).to eq(season)
  end
end
