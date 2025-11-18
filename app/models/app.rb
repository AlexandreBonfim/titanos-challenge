class App < ApplicationRecord
  has_many :availabilities, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
