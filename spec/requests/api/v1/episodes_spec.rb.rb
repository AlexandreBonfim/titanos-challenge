require "rails_helper"

RSpec.describe "Episodes API", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before { Streams::Importer.new(data: data).call }

  describe "GET /api/v1/episodes/:id" do
    it "returns an episode" do
      episode = Episode.first

      get "/api/v1/episodes/#{episode.id}"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["id"]).to eq(episode.id)
      expect(body["type"]).to eq("episode")
      expect(body["original_title"]).to eq(episode.original_title)
      expect(body["number"]).to eq(episode.number)
      expect(body["tv_show_id"]).to eq(episode.tv_show_id)
      expect(body["season_id"]).to eq(episode.season_id)
    end

    it "returns 404 when record does not exist" do
      get "/api/v1/episodes/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body).dig("error", "code")).to eq("not_found")
    end
  end
end
