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
