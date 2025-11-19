require "rails_helper"

RSpec.describe FavoriteApp, type: :model do
  let(:app) { App.create!(name: "netflix") }

  it "is valid with user_id, app and position" do
    fav = described_class.new(user_id: 1, app: app, position: 1)

    expect(fav).to be_valid
  end

  it "requires user_id" do
    fav = described_class.new(user_id: nil, app: app, position: 1)

    expect(fav).not_to be_valid
    expect(fav.errors[:user_id]).to be_present
  end

  it "requires position to be positive" do
    fav = described_class.new(user_id: 1, app: app, position: 0)

    expect(fav).not_to be_valid
    expect(fav.errors[:position]).to be_present
  end

  it "enforces uniqueness per user and app" do
    described_class.create!(user_id: 1, app: app, position: 1)

    duplicate = described_class.new(user_id: 1, app: app, position: 2)

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:user_id]).to be_present
  end
end
