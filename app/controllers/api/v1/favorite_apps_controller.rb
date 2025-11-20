module Api
  module V1
    class FavoriteAppsController < ApplicationController
      def index
        user_id = params[:user_id]

        favorites = FavoriteApp.includes(:app)
                               .where(user_id: user_id)
                               .order(:position)

        render json: ApplicationSerializer.serialize_collection(favorites, FavoriteAppSerializer)
      end

      def create
        user_id  = params[:user_id]
        app_id   = params.require(:app_id)
        position = params.require(:position)

        app = App.find(app_id)

        favorite = FavoriteApp.find_or_initialize_by(user_id: user_id, app: app)
        favorite.position = position

        if favorite.save
          render json: FavoriteAppSerializer.serialize(favorite)
        else
          render json: {
            error: {
              code: "validation_error",
              message: favorite.errors.full_messages.to_sentence
            }
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
