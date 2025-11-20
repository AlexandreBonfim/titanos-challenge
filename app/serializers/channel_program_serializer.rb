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
