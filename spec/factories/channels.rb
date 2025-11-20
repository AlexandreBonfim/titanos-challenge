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
FactoryBot.define do
  factory :channel do
    original_title { "MyString" }
    year { 1 }
    duration_in_seconds { 1 }
  end
end
