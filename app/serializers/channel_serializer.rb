# == Schema Information
#
# Table name: channels
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class ChannelSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "channel",
      original_title: record.original_title,
      year: record.year
    }
  end
end
