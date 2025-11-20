# spec/services/search/contents_spec.rb
require "rails_helper"

RSpec.describe Search::Contents do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before { Streams::Importer.new(data: data).call }

  it "returns movies matching the query" do
    results = described_class.new("star").call

    titles = results.map { |r| r[:original_title] || r["original_title"] }
    expect(titles.compact).to include("Star Wars: Episode V - The Empire Strikes Back")
  end

  it "returns apps matching the query" do
    results = described_class.new("netflix").call

    app_result = results.find { |r| (r[:type] || r["type"]) == "app" }
    expect(app_result).not_to be_nil
  end

  context "when a serializer is missing" do
    it "logs a warning and excludes the item from results" do
      create(:movie, original_title: "Test Movie Without Serializer")

      # Temporarily modify the SERIALIZER_MAP for this test
      original_map = Search::Contents::SERIALIZER_MAP
      stub_const("Search::Contents::SERIALIZER_MAP", original_map.except("Movie"))

      expect(Rails.logger).to receive(:warn).with("No serializer found for searchable_type: Movie")

      results = described_class.new("Test Movie").call

      titles = results.map { |r| r[:original_title] || r["original_title"] }
      expect(titles).not_to include("Test Movie Without Serializer")
    end
  end
end
