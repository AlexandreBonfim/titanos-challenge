# == Schema Information
#
# Table name: episodes
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  number              :integer
#  original_title      :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  season_id           :bigint           not null
#  tv_show_id          :bigint           not null
#
# Indexes
#
#  index_episodes_on_season_id   (season_id)
#  index_episodes_on_tv_show_id  (tv_show_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (tv_show_id => tv_shows.id)
#
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
