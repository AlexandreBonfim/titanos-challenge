# == Schema Information
#
# Table name: content_items
#
#  id              :bigint           not null, primary key
#  original_title  :string
#  searchable_type :string           not null
#  year            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  searchable_id   :bigint           not null
#
# Indexes
#
#  index_content_items_on_searchable  (searchable_type,searchable_id)
#
require 'rails_helper'

RSpec.describe ContentItem, type: :model do
    it "belongs to a searchable object" do
      movie = create(:movie)
      content_item = create(:content_item, searchable: movie)

      expect(content_item.searchable).to eq(movie)
    end

    it "is not valid without a searchable" do
      content_item = build(:content_item, searchable: nil)

      expect(content_item).not_to be_valid
    end

    it "is not valid without an original_title" do
      content_item = build(:content_item, original_title: nil)

      expect(content_item).not_to be_valid
    end
end
