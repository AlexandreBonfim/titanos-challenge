require "rails_helper"

RSpec.describe Streams::Importer do
  let(:data) do
    file = Rails.root.join("spec/fixtures/streams_data.json")
    JSON.parse(File.read(file))
  end

  subject(:import!) { described_class.new(data: data).call }

  describe "#call" do
    it "imports movies, tv shows, seasons, episodes, channels and channel programs" do
      expect { import! }
        .to change(Movie, :count).from(0).to(4)
        .and change(TvShow, :count).from(0).to(2)
        .and change(Season, :count).from(0).to(7)
        .and change(Episode, :count).from(0).to(7)
        .and change(Channel, :count).from(0).to(2)
        .and change(ChannelProgram, :count).from(0).to(3)
    end

    it "creates apps based on availabilities" do
      import!

      expect(App.pluck(:name)).to match_array(%w[netflix prime_video Amagi Wurl])
    end

    it "creates correct availabilities for a sample movie" do
      import!

      movie = Movie.find_by!(original_title: "Star Wars: Episode V - The Empire Strikes Back")
      expect(movie.availabilities.count).to eq(2)

      pairs = movie.availabilities.includes(:app).map { |a| [ a.app.name, a.market ] }
      expect(pairs).to match_array(
        [ [ "netflix", "gb" ], [ "prime_video", "es" ] ]
      )
    end

    it "is idempotent by clearing previous data before import" do
      described_class.new(data: data).call

      expect {
        described_class.new(data: data).call
      }.not_to change(Movie, :count)

      expect(Movie.count).to eq(4)
    end
  end
end
