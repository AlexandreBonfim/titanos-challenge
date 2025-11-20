module Search
  class Contents
    def initialize(query)
      @query = query.to_s.strip
    end

    def call
      return [] if @query.blank?

      pattern = like_pattern(@query)
      year    = parse_year(@query)

      results  = []
      results += search(Movie, MovieSerializer, :original_title, pattern, year)
      results += search(TvShow, TvShowSerializer, :original_title, pattern, year)
      results += search(Season, SeasonSerializer, :original_title, pattern, year)
      results += search(Episode, EpisodeSerializer, :original_title, pattern, year)
      results += search(Channel, ChannelSerializer, :original_title, pattern, year)
      results += search(ChannelProgram, ChannelProgramSerializer, :original_title, pattern, year)
      results += search_apps(pattern)

      results
    end

    private

    def like_pattern(query) = "%#{query.downcase}%"

    def parse_year(query)
      Integer(query, exception: false)
    end

    def search(model, serializer, column, pattern, year)
      scope = model.where("LOWER(#{column}) LIKE ?", pattern)
      scope = scope.or(model.where(year: year)) if year

      ApplicationSerializer.serialize_collection(scope.limit(50), serializer)
    end

    def search_apps(pattern)
      scope = App.where("LOWER(name) LIKE ?", pattern)

      ApplicationSerializer.serialize_collection(scope.limit(50), AppSerializer)
    end
  end
end
