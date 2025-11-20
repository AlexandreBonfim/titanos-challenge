require "rails_helper"

RSpec.describe Favorites::UpsertApp do
  let(:app) { App.create!(name: "netflix") }
  let(:user_id) { 1 }

  it "creates a new favorite" do
    favorite = described_class.new(user_id: user_id, app_id: app.id, position: 1).call

    expect(favorite).to be_persisted
    expect(favorite.position).to eq(1)
  end

  it "updates position when favorite already exists" do
    FavoriteApp.create!(user_id: user_id, app: app, position: 1)

    favorite = described_class.new(user_id: user_id, app_id: app.id, position: 3).call

    expect(favorite.position).to eq(3)
    expect(FavoriteApp.count).to eq(1)
  end
end
