# == Schema Information
#
# Table name: movies
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class MovieSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "movie",
      original_title: record.original_title,
      year: record.year,
      duration_in_seconds: record.duration_in_seconds
    }
  end
end
