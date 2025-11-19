# spec/models/watch_event_spec.rb
require "rails_helper"

RSpec.describe WatchEvent, type: :model do
  let(:channel) { Channel.create!(original_title: "Test Channel") }
  let(:program) { ChannelProgram.create!(channel: channel, original_title: "Test Program") }

  it "is valid with user_id, channel_program and watched_seconds" do
    event = described_class.new(
      user_id: 1,
      channel_program: program,
      watched_seconds: 120
    )

    expect(event).to be_valid
  end

  it "requires user_id" do
    event = described_class.new(
      user_id: nil,
      channel_program: program,
      watched_seconds: 120
    )

    expect(event).not_to be_valid
    expect(event.errors[:user_id]).to be_present
  end

  it "requires non-negative watched_seconds" do
    event = described_class.new(
      user_id: 1,
      channel_program: program,
      watched_seconds: -10
    )

    expect(event).not_to be_valid
    expect(event.errors[:watched_seconds]).to be_present
  end

  it "enforces uniqueness per user and channel_program" do
    described_class.create!(
      user_id: 1,
      channel_program: program,
      watched_seconds: 60
    )

    duplicate = described_class.new(
      user_id: 1,
      channel_program: program,
      watched_seconds: 30
    )

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:user_id]).to be_present
  end
end
