require "rails_helper"

RSpec.describe "User favorite apps", type: :request do
  let(:data) { JSON.parse(File.read(Rails.root.join("spec/fixtures/streams_data.json"))) }

  before do
    Streams::Importer.new(data: data).call
  end

  let(:user_id) { 42 }

  describe "GET /api/v1/users/:user_id/favorite_apps" do
    it "returns favorite apps ordered by position" do
      netflix = App.find_by!(name: "netflix")
      prime   = App.find_by!(name: "prime_video")

      FavoriteApp.create!(user_id: user_id, app: prime,   position: 2)
      FavoriteApp.create!(user_id: user_id, app: netflix, position: 1)

      get "/api/v1/users/#{user_id}/favorite_apps"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(2)
      expect(body.first["app_name"]).to eq("netflix")
      expect(body.first["position"]).to eq(1)
      expect(body.last["app_name"]).to eq("prime_video")
      expect(body.last["position"]).to eq(2)
    end

    it "returns empty array when user has no favorites" do
      get "/api/v1/users/#{user_id}/favorite_apps"

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body).to eq([])
    end
  end

  describe "POST /api/v1/users/:user_id/favorite_apps" do
    it "creates a new favorite when none exists" do
      netflix = App.find_by!(name: "netflix")

      expect {
        post "/api/v1/users/#{user_id}/favorite_apps",
             params: { app_id: netflix.id, position: 1 }
      }.to change(FavoriteApp, :count).by(1)

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["app_id"]).to eq(netflix.id)
      expect(body["position"]).to eq(1)
    end

    it "updates the position when favorite already exists" do
      netflix = App.find_by!(name: "netflix")
      FavoriteApp.create!(user_id: user_id, app: netflix, position: 1)

      expect {
        post "/api/v1/users/#{user_id}/favorite_apps",
             params: { app_id: netflix.id, position: 3 }
      }.not_to change(FavoriteApp, :count)

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body["position"]).to eq(3)
      expect(FavoriteApp.find_by(user_id: user_id, app: netflix).position).to eq(3)
    end

    it "returns 404 if app does not exist" do
      post "/api/v1/users/#{user_id}/favorite_apps",
           params: { app_id: 999_999, position: 1 }

      body = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
      expect(body.dig("error", "code")).to eq("not_found")
    end
  end
end
