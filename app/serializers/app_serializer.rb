class AppSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "app",
      name: record.name
    }
  end
end
