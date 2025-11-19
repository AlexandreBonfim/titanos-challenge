require "rails_helper"

RSpec.describe "ChannelPrograms API", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before { Streams::Importer.new(data: data).call }

  describe "GET /api/v1/channel_programs/:id" do
    it "returns a channel program with watched_seconds for the user" do
      user_id = 10
      program = ChannelProgram.first

      WatchEvent.create!(user_id: user_id, channel_program: program, watched_seconds: 123)

      get "/api/v1/channel_programs/#{program.id}", params: { user_id: user_id }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["id"]).to eq(program.id)
      expect(body["type"]).to eq("channel_program")
      expect(body["original_title"]).to eq(program.original_title)
      expect(body["watched_seconds"]).to eq(123)
    end

    it "returns watched_seconds = 0 when no watch event exists" do
      program = ChannelProgram.first

      get "/api/v1/channel_programs/#{program.id}", params: { user_id: 50 }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["watched_seconds"]).to eq(0)
    end

    it "returns 404 when record does not exist" do
      get "/api/v1/channel_programs/999999", params: { user_id: 1 }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body).dig("error", "code")).to eq("not_found")
    end
  end
end
