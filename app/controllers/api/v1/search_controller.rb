module Api
  module V1
    class SearchController < ApplicationController
      def index
        query = params.require(:query).to_s.strip
        return render json: [] if query.blank?

        results = []
        results += search_movies(query)
        results += search_tv_shows(query)
        results += search_seasons(query)
        results += search_episodes(query)
        results += search_channels(query)
        results += search_channel_programs(query)
        results += search_apps(query)

        render json: results
      end

      private

      def like_pattern(query)
        "%#{query.downcase}%"
      end

      def parse_year(query)
        Integer(query, exception: false)
      end

      def search_movies(query)
        pattern = like_pattern(query)
        year = parse_year(query)

        scope = Movie.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Movie.where(year: year)) if year

        scope.limit(50).map do |movie|
          {
            id: movie.id,
            type: "movie",
            original_title: movie.original_title,
            year: movie.year,
            duration_in_seconds: movie.duration_in_seconds
          }
        end
      end

      def search_tv_shows(query)
        pattern = like_pattern(query)
        year = parse_year(query)

        scope = TvShow.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(TvShow.where(year: year)) if year

        scope.limit(50).map do |tv|
          {
            id: tv.id,
            type: "tv_show",
            original_title: tv.original_title,
            year: tv.year,
            duration_in_seconds: tv.duration_in_seconds
          }
        end
      end

      def search_seasons(query)
        pattern = like_pattern(query)
        year = parse_year(query)

        scope = Season.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Season.where(year: year)) if year

        scope.limit(50).map do |season|
          {
            id: season.id,
            type: "season",
            original_title: season.original_title,
            year: season.year,
            number: season.number,
            tv_show_id: season.tv_show_id
          }
        end
      end

      def search_episodes(query)
        pattern = like_pattern(query)
        year = parse_year(query)

        scope = Episode.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Episode.where(year: year)) if year

        scope.limit(50).map do |ep|
          {
            id: ep.id,
            type: "episode",
            original_title: ep.original_title,
            year: ep.year,
            number: ep.number,
            tv_show_id: ep.tv_show_id,
            season_id: ep.season_id
          }
        end
      end

      def search_channels(query)
        pattern = like_pattern(query)
        year = parse_year(query)

        scope = Channel.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Channel.where(year: year)) if year

        scope.limit(50).map do |ch|
          {
            id: ch.id,
            type: "channel",
            original_title: ch.original_title,
            year: ch.year
          }
        end
      end

      def search_channel_programs(query)
        pattern = like_pattern(query)
        year = parse_year(query)

        scope = ChannelProgram.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(ChannelProgram.where(year: year)) if year

        scope.limit(50).map do |cp|
          {
            id: cp.id,
            type: "channel_program",
            original_title: cp.original_title,
            year: cp.year,
            duration_in_seconds: cp.duration_in_seconds
          }
        end
      end

      def search_apps(query)
        pattern = like_pattern(query)

        App.where("LOWER(name) LIKE ?", pattern)
           .limit(50)
           .map do |app|
             {
               id: app.id,
               type: "app",
               name: app.name
             }
           end
      end
    end
  end
end
