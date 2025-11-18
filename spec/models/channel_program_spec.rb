require "rails_helper"

RSpec.describe ChannelProgram, type: :model do
  it "belongs to a channel" do
    channel = Channel.create!(original_title: "Nickelodeon")
    program = ChannelProgram.create!(channel: channel, original_title: "SpongeBob")

    expect(program.channel).to eq(channel)
  end

  it "can store schedule as JSON" do
    channel = Channel.create!(original_title: "Nickelodeon")
    program = ChannelProgram.create!(
      channel: channel,
      original_title: "SpongeBob",
      schedule: [
        { "start_time" => "2024-03-11 08:00:00", "end_time" => "2024-03-11 09:00:00" }
      ]
    )

    expect(program.schedule).to be_an(Array)
  end
end
