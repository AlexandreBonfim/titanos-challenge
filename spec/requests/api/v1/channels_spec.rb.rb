require "rails_helper"

RSpec.describe "Channels API", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before { Streams::Importer.new(data: data).call }

  describe "GET /api/v1/channels/:id" do
    it "returns a channel" do
      channel = Channel.first

      get "/api/v1/channels/#{channel.id}"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["id"]).to eq(channel.id)
      expect(body["type"]).to eq("channel")
      expect(body["original_title"]).to eq(channel.original_title)
      expect(body["year"]).to eq(channel.year)
    end

    it "returns 404 when record does not exist" do
      get "/api/v1/channels/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body).dig("error", "code")).to eq("not_found")
    end
  end
end
