module Favorites
  class UpsertApp
    def initialize(user_id:, app_id:, position:)
      @user_id  = user_id
      @app_id   = app_id
      @position = position.to_i
    end

    def call
      app = App.find(@app_id)
      favorite = FavoriteApp.find_or_initialize_by(user_id: @user_id, app: app)
      favorite.position = @position
      favorite.tap(&:save!)
    end
  end
end
