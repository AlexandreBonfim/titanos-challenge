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
