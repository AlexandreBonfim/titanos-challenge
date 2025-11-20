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
FactoryBot.define do
  factory :season do
    tv_show { nil }
    original_title { "MyString" }
    number { 1 }
    year { 1 }
    duration_in_seconds { 1 }
  end
end
