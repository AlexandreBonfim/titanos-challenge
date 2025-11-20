class FavoriteAppSerializer < ApplicationSerializer
  def as_json(*)
    {
      app_id: record.app_id,
      app_name: record.app.name,
      position: record.position
    }
  end
end
