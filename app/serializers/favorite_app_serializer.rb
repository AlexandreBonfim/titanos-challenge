# == Schema Information
#
# Table name: favorite_apps
#
#  id         :bigint           not null, primary key
#  position   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  app_id     :bigint           not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_favorite_apps_on_app_id                (app_id)
#  index_favorite_apps_on_user_id_and_app_id    (user_id,app_id) UNIQUE
#  index_favorite_apps_on_user_id_and_position  (user_id,position)
#
# Foreign Keys
#
#  fk_rails_...  (app_id => apps.id)
#
class FavoriteAppSerializer < ApplicationSerializer
  def as_json(*)
    {
      app_id: record.app_id,
      app_name: record.app.name,
      position: record.position
    }
  end
end
