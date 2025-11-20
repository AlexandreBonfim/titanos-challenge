class ContentItem < ApplicationRecord
  belongs_to :searchable, polymorphic: true

  validates :original_title, presence: true
  validates :searchable, presence: true
end
