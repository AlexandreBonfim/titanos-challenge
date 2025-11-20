module Api
  module V1
    class MoviesController < ApplicationController
      def show
        movie = Movie.find(params[:id])

        render json: MovieSerializer.serialize(movie)
      end
    end
  end
end
