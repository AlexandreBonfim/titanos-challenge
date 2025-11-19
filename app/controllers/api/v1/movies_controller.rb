module Api
  module V1
    class MoviesController < ApplicationController
      def show
        movie = Movie.find(params[:id])

        render json: {
          id: movie.id,
          type: "movie",
          original_title: movie.original_title,
          year: movie.year,
          duration_in_seconds: movie.duration_in_seconds
        }
      end
    end
  end
end
