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
end
