require "rails_helper"

RSpec.describe Season, type: :model do
  it "belongs to a tv_show" do
    tv = TvShow.create!(original_title: "Demon Slayer", year: 2019)
    season = Season.create!(tv_show: tv, original_title: "S1", number: 1, year: 2019)

    expect(season.tv_show).to eq(tv)
  end
end
