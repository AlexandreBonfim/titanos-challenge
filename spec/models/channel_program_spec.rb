# == Schema Information
#
# Table name: channel_programs
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string           not null
#  schedule            :jsonb            not null
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  channel_id          :bigint           not null
#
# Indexes
#
#  index_channel_programs_on_channel_id      (channel_id)
#  index_channel_programs_on_original_title  (original_title)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
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
