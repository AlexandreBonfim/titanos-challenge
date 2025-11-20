module Favorites
  class AppsForUser
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      FavoriteApp.includes(:app)
                 .where(user_id: @user_id)
                 .order(:position)
    end
  end
end
