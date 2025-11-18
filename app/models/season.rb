class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy
  has_many :availabilities, as: :available, dependent: :destroy

  validates :original_title, presence: true
  validates :number, presence: true
end
