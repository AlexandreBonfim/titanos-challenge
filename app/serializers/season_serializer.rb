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
class SeasonSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "season",
      original_title: record.original_title,
      number: record.number,
      year: record.year,
      tv_show_id: record.tv_show_id
    }
  end
end
