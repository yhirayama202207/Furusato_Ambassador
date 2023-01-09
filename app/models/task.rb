class Task < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :itinerary
  belongs_to :user
end
