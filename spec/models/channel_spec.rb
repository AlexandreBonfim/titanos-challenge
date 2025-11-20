# == Schema Information
#
# Table name: channels
#
#  id                  :bigint           not null, primary key
#  duration_in_seconds :integer
#  original_title      :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "rails_helper"

RSpec.describe Channel, type: :model do
  it "is valid with a title" do
    channel = described_class.new(original_title: "Nickelodeon")

    expect(channel).to be_valid
  end

  it "has many channel_programs" do
    channel = Channel.create!(original_title: "Nickelodeon")
    program = ChannelProgram.create!(channel: channel, original_title: "SpongeBob")

    expect(channel.channel_programs).to include(program)
  end
end
