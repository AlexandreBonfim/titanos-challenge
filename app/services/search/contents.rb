module Search
  class Contents
    SERIALIZER_MAP = {
      "Movie" => MovieSerializer,
      "TvShow" => TvShowSerializer,
      "Season" => SeasonSerializer,
      "Episode" => EpisodeSerializer,
      "Channel" => ChannelSerializer,
      "ChannelProgram" => ChannelProgramSerializer
    }.freeze

    def initialize(query)
      @query = query.to_s.strip
    end

    def call
      return [] if @query.blank?

      pattern = like_pattern(@query)
      year    = parse_year(@query)

      results  = search_content_items(pattern, year)
      results += search_apps(pattern)

      results.shuffle
    end

    private

    def like_pattern(query) = "%#{query.downcase}%"

    def parse_year(query)
      Integer(query, exception: false)
    end

    def serializer_for(searchable_type)
      SERIALIZER_MAP[searchable_type]
    end

    def search_content_items(pattern, year)
      scope = ContentItem.includes(:searchable).where("LOWER(original_title) LIKE ?", pattern)
      scope = scope.or(ContentItem.where(year: year)) if year

      scope.limit(50).map do |content_item|
        serializer_class = serializer_for(content_item.searchable_type)
        if serializer_class
          serializer_class.serialize(content_item.searchable)
        else
          Rails.logger.warn("No serializer found for searchable_type: #{content_item.searchable_type}")
          nil
        end
      end.compact
    end

    def search_apps(pattern)
      scope = App.where("LOWER(name) LIKE ?", pattern)

      ApplicationSerializer.serialize_collection(scope.limit(50), AppSerializer)
    end
  end
end
