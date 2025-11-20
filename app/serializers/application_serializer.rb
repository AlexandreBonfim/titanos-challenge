class ApplicationSerializer
  attr_reader :record, :context

  def initialize(record, context: {})
    @record  = record
    @context = context
  end

  def self.serialize(record, context: {})
    new(record, context: context).as_json
  end

  # For collections: ApplicationSerializer.serialize_collection(Movie.all, MovieSerializer)
  def self.serialize_collection(records, serializer_class, context: {})
    records.map { |r| serializer_class.serialize(r, context: context) }
  end
end
