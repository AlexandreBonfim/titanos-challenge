class FavoriteApp < ApplicationRecord
  belongs_to :app

  validates :user_id, presence: true
  validates :position, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }

  validates :user_id, uniqueness: { scope: :app_id }
end
