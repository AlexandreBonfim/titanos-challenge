module Api
  module V1
    class TvShowsController < ApplicationController
      def show
        tv = TvShow.find(params[:id])

        render json: TvShowSerializer.serialize(tv)
      end
    end
  end
end
