require "rails_helper"

RSpec.describe Favorites::ChannelProgramsForUser do
  describe "#call" do
    let(:user_id) { 42 }
    let(:other_user_id) { 99 }
    let(:channel) { create(:channel) }
    let(:program1) { create(:channel_program, channel: channel) }
    let(:program2) { create(:channel_program, channel: channel) }

    before do
      create(:watch_event, user_id: user_id, channel_program: program1, watched_seconds: 100)
      create(:watch_event, user_id: user_id, channel_program: program2, watched_seconds: 300)
      create(:watch_event, user_id: other_user_id, channel_program: program1, watched_seconds: 500)
    end

    it "returns only watch events for the given user" do
      results = described_class.new(user_id).call

      expect(results.map(&:user_id).uniq).to eq([ user_id ])
    end

    it "orders watch events by watched_seconds desc" do
      results = described_class.new(user_id).call

      expect(results.map(&:watched_seconds)).to eq([ 300, 100 ])
    end

    it "returns empty array if user has no events" do
      results = described_class.new(12345).call
      expect(results).to eq([])
    end
  end
end
