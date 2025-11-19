require "rails_helper"

RSpec.describe "Movies API", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before { Streams::Importer.new(data: data).call }

  describe "GET /api/v1/movies/:id" do
    it "returns a movie" do
      movie = Movie.first

      get "/api/v1/movies/#{movie.id}"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["id"]).to eq(movie.id)
      expect(body["type"]).to eq("movie")
      expect(body["original_title"]).to eq(movie.original_title)
    end

    it "returns 404 when record does not exist" do
      get "/api/v1/movies/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body).dig("error", "code")).to eq("not_found")
    end
  end
end
