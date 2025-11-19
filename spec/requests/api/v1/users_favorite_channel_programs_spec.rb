require "rails_helper"

RSpec.describe "User favorite channel programs", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before do
    Streams::Importer.new(data: data).call
  end

  describe "GET /api/v1/users/:user_id/favorite_channel_programs" do
    it "returns channel programs ordered by watched_seconds desc" do
      user_id = 1
      p1, p2 = ChannelProgram.first(2)

      WatchEvent.create!(user_id: user_id, channel_program: p1, watched_seconds: 50)
      WatchEvent.create!(user_id: user_id, channel_program: p2, watched_seconds: 150)

      get "/api/v1/users/#{user_id}/favorite_channel_programs"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(2)
      # ordered by watched_seconds desc
      expect(body.first["id"]).to eq(p2.id)
      expect(body.first["watched_seconds"]).to eq(150)
      expect(body.last["id"]).to eq(p1.id)
      expect(body.last["watched_seconds"]).to eq(50)
    end

    it "returns empty array when user has no watch events" do
      get "/api/v1/users/999/favorite_channel_programs"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body).to eq([])
    end
  end
end
