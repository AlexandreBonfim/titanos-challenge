require "rails_helper"

RSpec.describe Favorites::AppsForUser do
  let(:user_id) { 7 }
  let(:netflix) { App.create!(name: "netflix") }
  let(:prime)   { App.create!(name: "prime_video") }

  it "returns favorites ordered by position" do
    FavoriteApp.create!(user_id: user_id, app: prime,   position: 2)
    FavoriteApp.create!(user_id: user_id, app: netflix, position: 1)

    result = described_class.new(user_id).call

    expect(result.map(&:app)).to eq([ netflix, prime ])
    expect(result.map(&:position)).to eq([ 1, 2 ])
  end

  it "returns empty relation when user has no favorites" do
    result = described_class.new(user_id).call

    expect(result).to be_empty
  end
end
