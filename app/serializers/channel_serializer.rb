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
