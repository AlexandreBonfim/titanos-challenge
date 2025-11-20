class EpisodeSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "episode",
      original_title: record.original_title,
      number: record.number,
      year: record.year,
      tv_show_id: record.tv_show_id,
      season_id: record.season_id
    }
  end
end
