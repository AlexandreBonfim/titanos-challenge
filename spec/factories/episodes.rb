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
FactoryBot.define do
  factory :episode do
    tv_show { nil }
    season { nil }
    original_title { "MyString" }
    number { 1 }
    year { 1 }
    duration_in_seconds { 1 }
  end
end
