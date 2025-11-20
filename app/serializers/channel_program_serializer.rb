# == Schema Information
#
# Table name: channel_programs
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string           not null
#  schedule            :jsonb            not null
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  channel_id          :bigint           not null
#
# Indexes
#
#  index_channel_programs_on_channel_id      (channel_id)
#  index_channel_programs_on_original_title  (original_title)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
class ChannelProgramSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "channel_program",
      original_title: record.original_title,
      year: record.year,
      duration_in_seconds: record.duration_in_seconds,
      schedule: record.schedule,
      watched_seconds: watched_seconds
    }
  end

  private

  def watched_seconds
    context[:watched_seconds] || 0
  end
end
