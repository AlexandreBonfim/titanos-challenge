module Api
  module V1
    class SearchController < ApplicationController
      def index
        query = params.require(:query)
        results = Search::Contents.new(query).call

        render json: results
      end
    end
  end
end
