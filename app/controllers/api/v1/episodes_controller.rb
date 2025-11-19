module Api
  module V1
    class EpisodesController < ApplicationController
      def show
        ep = Episode.find(params[:id])

        render json: {
          id: ep.id,
          type: "episode",
          original_title: ep.original_title,
          number: ep.number,
          year: ep.year,
          tv_show_id: ep.tv_show_id,
          season_id: ep.season_id
        }
      end
    end
  end
end
