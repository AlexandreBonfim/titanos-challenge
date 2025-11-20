module Api
  module V1
    class SeasonsController < ApplicationController
      def show
        season = Season.find(params[:id])

        render json: SeasonSerializer.serialize(season)
      end
    end
  end
end
