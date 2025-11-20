module Api
  module V1
    class ChannelsController < ApplicationController
      def show
        channel = Channel.find(params[:id])

        render json: ChannelSerializer.serialize(channel)
      end
    end
  end
end
