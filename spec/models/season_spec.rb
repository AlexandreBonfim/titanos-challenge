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
require "rails_helper"

RSpec.describe Season, type: :model do
  it "belongs to a tv_show" do
    tv = TvShow.create!(original_title: "Demon Slayer", year: 2019)
    season = Season.create!(tv_show: tv, original_title: "S1", number: 1, year: 2019)

    expect(season.tv_show).to eq(tv)
  end
end
