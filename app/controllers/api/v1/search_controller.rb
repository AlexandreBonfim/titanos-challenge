module Api
  module V1
    class SearchController < ApplicationController
      def index
        query = params.require(:query).to_s.strip

        return render json: [] if query.blank?

        pattern = like_pattern(query)
        year    = parse_year(query)

        results = []
        results += search_movies(pattern, year)
        results += search_tv_shows(pattern, year)
        results += search_seasons(pattern, year)
        results += search_episodes(pattern, year)
        results += search_channels(pattern, year)
        results += search_channel_programs(pattern, year)
        results += search_apps(pattern)

        render json: results
      end

      private

      def like_pattern(query)
        "%#{query.downcase}%"
      end

      def parse_year(query)
        Integer(query, exception: false)
      end

      def search_movies(pattern, year)
        scope = Movie.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Movie.where(year: year)) if year

        ApplicationSerializer.serialize_collection(scope.limit(50), MovieSerializer)
      end

      def search_tv_shows(pattern, year)
        scope = TvShow.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(TvShow.where(year: year)) if year

        ApplicationSerializer.serialize_collection(scope.limit(50), TvShowSerializer)
      end

      def search_seasons(pattern, year)
        scope = Season.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Season.where(year: year)) if year

        ApplicationSerializer.serialize_collection(scope.limit(50), SeasonSerializer)
      end

      def search_episodes(pattern, year)
        scope = Episode.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Episode.where(year: year)) if year

        ApplicationSerializer.serialize_collection(scope.limit(50), EpisodeSerializer)
      end

      def search_channels(pattern, year)
        scope = Channel.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(Channel.where(year: year)) if year

        ApplicationSerializer.serialize_collection(scope.limit(50), ChannelSerializer)
      end

      def search_channel_programs(pattern, year)
        scope = ChannelProgram.where("LOWER(original_title) LIKE ?", pattern)
        scope = scope.or(ChannelProgram.where(year: year)) if year

        ApplicationSerializer.serialize_collection(scope.limit(50), ChannelProgramSerializer)
      end

      def search_apps(pattern)
        scope = App.where("LOWER(name) LIKE ?", pattern)

        ApplicationSerializer.serialize_collection(scope.limit(50), AppSerializer)
      end
    end
  end
end
