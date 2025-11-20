# == Schema Information
#
# Table name: apps
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_apps_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe App, type: :model do
  it "is valid with a unique name" do
    app = described_class.new(name: "netflix")

    expect(app).to be_valid
  end

  it "is invalid without a name" do
    app = described_class.new(name: nil)

    expect(app).not_to be_valid
    expect(app.errors[:name]).to be_present
  end

  it "enforces name uniqueness" do
    described_class.create!(name: "netflix")
    duplicate = described_class.new(name: "netflix")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:name]).to be_present
  end
end
