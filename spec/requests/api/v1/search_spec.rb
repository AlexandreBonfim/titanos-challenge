require "rails_helper"

RSpec.describe "Search API", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before do
    Streams::Importer.new(data: data).call
  end

  describe "GET /api/v1/search" do
    it "returns 400 when query is missing" do
      get "/api/v1/search"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(body.dig("error", "code")).to eq("missing_parameter")
    end

    it "searches across movies and tv shows by title" do
      get "/api/v1/search", params: { query: "star" }

      body = JSON.parse(response.body)
      # Should at least include "Star Wars: Episode V - The Empire Strikes Back"
      titles = body.map { |item| item["original_title"] }
      types = body.map { |item| item["type"] }.uniq

      expect(response).to have_http_status(:ok)
      expect(titles).to include("Star Wars: Episode V - The Empire Strikes Back")
      expect(types).to include("movie")
    end

    it "searches apps by name" do
      get "/api/v1/search", params: { query: "netflix" }

      body = JSON.parse(response.body)
      app_result = body.find { |item| item["type"] == "app" }

      expect(response).to have_http_status(:ok)
      expect(app_result).not_to be_nil
      expect(app_result["name"]).to eq("netflix")
    end

    it "can search by year" do
      get "/api/v1/search", params: { query: "1980" }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      # 1980 is year of "Star Wars: Episode V - The Empire Strikes Back"
      expect(
        body.any? { |item| item["type"] == "movie" && item["year"] == 1980 }
      ).to be true
    end
  end
end
