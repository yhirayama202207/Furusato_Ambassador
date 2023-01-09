class Itinerary < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :user
end
