module Api
  module V1
    class ChannelProgramsController < ApplicationController
      def show
        program = ChannelProgram.find(params[:id])
        user_id = params[:user_id]

        watched = if user_id.present?
                    WatchEvent.where(user_id: user_id, channel_program: program)
                              .pluck(:watched_seconds)
                              .first || 0
        else
                    0
        end

        render json: ChannelProgramSerializer.serialize(program, context: { watched_seconds: watched })
      end
    end
  end
end
