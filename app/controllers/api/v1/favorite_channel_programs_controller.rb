module Api
  module V1
    class FavoriteChannelProgramsController < ApplicationController
      def index
        user_id = params[:user_id]

        events = WatchEvent
                   .includes(:channel_program)
                   .where(user_id: user_id)
                   .order(watched_seconds: :desc)

        render json: events.map { |event|
          program = event.channel_program

          {
            id: program.id,
            type: "channel_program",
            original_title: program.original_title,
            year: program.year,
            duration_in_seconds: program.duration_in_seconds,
            watched_seconds: event.watched_seconds
          }
        }
      end
    end
  end
end
