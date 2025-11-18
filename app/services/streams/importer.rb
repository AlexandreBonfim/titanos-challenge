module Streams
  class Importer
    class Error < StandardError; end

    def initialize(data:)
      @data = data
    end

    def call
      ActiveRecord::Base.transaction do
        reset_data!

        import_movies(@data.fetch("movies", []))
        import_tv_shows(@data.fetch("tv_shows", []))
        import_channels(@data.fetch("channels", []))
      end
    rescue KeyError => e
      raise Error, "Invalid streams data structure: #{e.message}"
    end

    private

    def reset_data!
      Availability.delete_all
      ChannelProgram.delete_all
      Channel.delete_all
      Episode.delete_all
      Season.delete_all
      TvShow.delete_all
      Movie.delete_all
      App.delete_all
    end

    # === Movies ===

    def import_movies(movies)
      movies.each do |movie_data|
        movie = Movie.create!(
          original_title: movie_data["original_title"],
          year: movie_data["year"],
          duration_in_seconds: movie_data["duration_in_seconds"]
        )

        import_availabilities(movie, movie_data["availabilities"] || [])
      end
    end

    # === TV Shows, Seasons, Episodes ===

    def import_tv_shows(tv_shows)
      tv_shows.each do |show_data|
        tv_show = TvShow.create!(
          original_title: show_data["original_title"],
          year: show_data["year"],
          duration_in_seconds: show_data["duration_in_seconds"]
        )

        # tv show level availabilities
        import_availabilities(tv_show, show_data["availabilities"] || [])

        # seasons
        season_by_number = {}
        (show_data["seasons"] || []).each do |season_data|
          season = Season.create!(
            tv_show: tv_show,
            original_title: season_data["original_title"],
            number: season_data["number"],
            year: season_data["year"],
            duration_in_seconds: season_data["duration_in_seconds"]
          )
          season_by_number[season.number] = season

          import_availabilities(season, season_data["availabilities"] || [])
        end

        # episodes (they reference season_number)
        (show_data["episodes"] || []).each do |episode_data|
          season = season_by_number.fetch(episode_data["season_number"])
          Episode.create!(
            tv_show: tv_show,
            season: season,
            original_title: episode_data["original_title"],
            number: episode_data["number"],
            year: episode_data["year"],
            duration_in_seconds: episode_data["duration_in_seconds"]
          )
        end
      end
    end

    # === Channels & ChannelPrograms ===

    def import_channels(channels)
      channels.each do |channel_data|
        channel = Channel.create!(
          original_title: channel_data["original_title"],
          year: channel_data["year"],
          duration_in_seconds: channel_data["duration_in_seconds"]
        )

        import_availabilities(channel, channel_data["availabilities"] || [])

        (channel_data["channel_programs"] || []).each do |program_data|
          program = ChannelProgram.create!(
            channel: channel,
            original_title: program_data["original_title"],
            year: program_data["year"],
            duration_in_seconds: program_data["duration_in_seconds"],
            schedule: program_data["schedule"] || []
          )

          import_availabilities(program, program_data["availabilities"] || [])
        end
      end
    end

    # === Shared helpers ===

    def import_availabilities(record, availabilities)
      availabilities.each do |availability_data|
        app = find_or_create_app(availability_data["app"])

        Availability.create!(
          app: app,
          available: record,
          market: availability_data["market"],
          stream_info: availability_data["stream_info"] || {}
        )
      end
    end

    def find_or_create_app(name)
      App.find_or_create_by!(name: name)
    end
  end
end
