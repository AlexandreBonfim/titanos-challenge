module Api
  module V1
    class ContentsController < ApplicationController
      TYPE_MAP = {
        "movie"           => Movie,
        "tv_show"         => TvShow,
        "season"          => Season,
        "episode"         => Episode,
        "channel"         => Channel,
        "channel_program" => ChannelProgram
      }.freeze

      def index
        country = params.require(:country)
        type    = params[:type]&.downcase

        if type.present? && !TYPE_MAP.key?(type)
          return render_invalid_type(type)
        end

        records =
          if type.present?
            klass = TYPE_MAP.fetch(type)
            records_for_type(klass, country).map { |record| serialize(record, type) }
          else
            TYPE_MAP.flat_map do |type_key, klass|
              records_for_type(klass, country).map { |record| serialize(record, type_key) }
            end
          end

        render json: records
      end

      private

      def render_invalid_type(type)
        render json: {
          error: {
            code: "invalid_type",
            message: "Unsupported type '#{type}'. " \
                     "Supported types: #{TYPE_MAP.keys.sort.join(', ')}"
          }
        }, status: :bad_request
      end

      def records_for_type(klass, country)
        if klass == Episode
          # Episodes are available when their season is available in that market.
          Episode
            .joins(season: :availabilities)
            .where(availabilities: { market: country })
            .distinct
        else
          ids = Availability
                  .where(market: country, available_type: klass.name)
                  .distinct
                  .pluck(:available_id)

          klass.where(id: ids)
        end
      end

      def serialize(record, type)
        {
          id: record.id,
          type: type,
          original_title: record.original_title,
          year: record.year,
          duration_in_seconds: record.duration_in_seconds
        }
      end
    end
  end
end
