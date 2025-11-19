module Api
  module V1
    class TvShowsController < ApplicationController
      def show
        tv = TvShow.find(params[:id])

        render json: {
          id: tv.id,
          type: "tv_show",
          original_title: tv.original_title,
          year: tv.year,
          duration_in_seconds: tv.duration_in_seconds,
          seasons_count: tv.seasons.count,
          episodes_count: tv.episodes.count
        }
      end
    end
  end
end
