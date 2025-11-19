require "rails_helper"

RSpec.describe "Seasons API", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before { Streams::Importer.new(data: data).call }

  describe "GET /api/v1/seasons/:id" do
    it "returns a season" do
      season = Season.first

      get "/api/v1/seasons/#{season.id}"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["id"]).to eq(season.id)
      expect(body["type"]).to eq("season")
      expect(body["original_title"]).to eq(season.original_title)
      expect(body["number"]).to eq(season.number)
      expect(body["tv_show_id"]).to eq(season.tv_show_id)
    end

    it "returns 404 when record does not exist" do
      get "/api/v1/seasons/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body).dig("error", "code")).to eq("not_found")
    end
  end
end
