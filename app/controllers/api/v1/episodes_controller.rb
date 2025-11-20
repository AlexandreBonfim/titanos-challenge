module Api
  module V1
    class EpisodesController < ApplicationController
      def show
        episode = Episode.find(params[:id])

        render json: EpisodeSerializer.serialize(episode)
      end
    end
  end
end
