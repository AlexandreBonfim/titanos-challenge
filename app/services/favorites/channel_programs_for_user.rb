module Favorites
  class ChannelProgramsForUser
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      WatchEvent.includes(:channel_program)
                .where(user_id: @user_id)
                .order(watched_seconds: :desc)
    end
  end
end
