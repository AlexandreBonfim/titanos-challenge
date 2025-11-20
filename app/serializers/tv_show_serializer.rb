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
class TvShowSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "tv_show",
      original_title: record.original_title,
      year: record.year,
      duration_in_seconds: record.duration_in_seconds,
      seasons_count: record.seasons.count,
      episodes_count: record.episodes.count
    }
  end
end
