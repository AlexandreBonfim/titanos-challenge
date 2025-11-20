module Api
  module V1
    class ContentsController < ApplicationController
      TYPE_MAP = {
        "movie"           => [ Movie, MovieSerializer ],
        "tv_show"         => [ TvShow, TvShowSerializer ],
        "season"          => [ Season, SeasonSerializer ],
        "episode"         => [ Episode, EpisodeSerializer ],
        "channel"         => [ Channel, ChannelSerializer ],
        "channel_program" => [ ChannelProgram, ChannelProgramSerializer ]
      }.freeze

      def index
        country = params.require(:country)
        type    = params[:type]&.downcase

        if type.present? && !TYPE_MAP.key?(type)
          return render_invalid_type(type)
        end

        records =
          if type.present?
            klass, serializer = TYPE_MAP.fetch(type)
            records_for_type(klass, country).map { |record|
              serializer.serialize(record)
            }
          else
            TYPE_MAP.flat_map do |type_key, (klass, serializer)|
              records_for_type(klass, country).map { |record|
                serializer.serialize(record)
              }
            end
          end

        render json: records
      end

      private

      def render_invalid_type(type)
        render json: {
          error: {
            code: "invalid_type",
            message: "Unsupported type '#{type}'. Supported types: #{TYPE_MAP.keys.sort.join(', ')}"
          }
        }, status: :bad_request
      end

      def records_for_type(klass, country)
        klass.available_in(country)
      end
    end
  end
end
