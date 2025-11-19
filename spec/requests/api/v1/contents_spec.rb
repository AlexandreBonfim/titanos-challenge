require "rails_helper"

RSpec.describe "Contents API", type: :request do
  let(:data) do
    file = Rails.root.join("spec/fixtures/streams_data.json")
    JSON.parse(File.read(file))
  end

  before do
    Streams::Importer.new(data: data).call
  end

  describe "GET /api/v1/contents" do
    it "returns 400 when country is missing" do
      get "/api/v1/contents"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(body.dig("error", "code")).to eq("missing_parameter")
    end

    it "returns movies for a given country when type=movie" do
      get "/api/v1/contents", params: { country: "gb", type: "movie" }

      body = JSON.parse(response.body)
      titles = body.map { |item| item["original_title"] }

      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(4) # all 4 movies available in gb
      expect(titles).to include(
        "Star Wars: Episode V - The Empire Strikes Back",
        "Interstellar"
      )
      expect(body.all? { |item| item["type"] == "movie" }).to be true
    end

    it "returns tv shows for a given country when type=tv_show" do
      get "/api/v1/contents", params: { country: "gb", type: "tv_show" }

      body = JSON.parse(response.body)
      types = body.map { |item| item["type"] }.uniq

      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(2)
      expect(types).to eq([ "tv_show" ])
    end

    it "returns episodes for a given country when type=episode" do
      get "/api/v1/contents", params: { country: "gb", type: "episode" }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      # 7 episodes total, all under seasons that are available in gb
      expect(body.size).to eq(7)
      expect(body.all? { |item| item["type"] == "episode" }).to be true
    end

    it "returns all supported content types when type is not provided" do
      get "/api/v1/contents", params: { country: "gb" }

      body = JSON.parse(response.body)
      types = body.map { |item| item["type"] }.uniq.sort

      expect(response).to have_http_status(:ok)
      expect(types).to include("movie", "tv_show", "season", "episode", "channel", "channel_program")
    end

    it "returns 400 for an invalid type" do
      get "/api/v1/contents", params: { country: "gb", type: "invalid_type" }


      body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(body.dig("error", "code")).to eq("invalid_type")
    end
  end
end
