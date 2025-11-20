module Api
  module V1
    class FavoriteChannelProgramsController < ApplicationController
      def index
        user_id = params[:user_id]

        events = WatchEvent.includes(:channel_program)
                           .where(user_id: user_id)
                           .order(watched_seconds: :desc)

        render json: events.map { |event|
          ChannelProgramSerializer.serialize(
            event.channel_program,
            context: { watched_seconds: event.watched_seconds }
          )
        }
      end
    end
  end
end
