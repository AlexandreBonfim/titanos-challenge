module Api
  module V1
    class FavoriteAppsController < ApplicationController
      def index
        favorites = Favorites::AppsForUser.new(params[:user_id]).call

        render json: ApplicationSerializer.serialize_collection(favorites, FavoriteAppSerializer)
      end

      def create
        favorite = Favorites::UpsertApp.new(
          user_id: params[:user_id],
          app_id:  params.require(:app_id),
          position: params.require(:position)
        ).call

        render json: FavoriteAppSerializer.serialize(favorite)
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: { code: "validation_error", message: e.record.errors.full_messages.to_sentence } },
               status: :unprocessable_entity
      end
    end
  end
end
