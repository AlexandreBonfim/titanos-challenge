module Searchable
  extend ActiveSupport::Concern

  included do
    has_one :content_item, as: :searchable, dependent: :destroy

    after_save :update_content_item
  end

  private

  def update_content_item
    item = content_item || build_content_item
    item.original_title = original_title
    item.year = year
    item.save
  end
end
