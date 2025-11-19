module Api
  module V1
    class SeasonsController < ApplicationController
      def show
        season = Season.find(params[:id])

        render json: {
          id: season.id,
          type: "season",
          original_title: season.original_title,
          number: season.number,
          year: season.year,
          tv_show_id: season.tv_show_id
        }
      end
    end
  end
end
