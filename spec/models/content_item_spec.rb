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
