module Api
  module V1
    class ChannelsController < ApplicationController
      def show
        ch = Channel.find(params[:id])

        render json: {
          id: ch.id,
          type: "channel",
          original_title: ch.original_title,
          year: ch.year
        }
      end
    end
  end
end
