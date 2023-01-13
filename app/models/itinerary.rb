class Itinerary < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :user

  with_options presence: true do
    validates :title, presence: { message: 'を入力してください' }
    validates :rate, presence: { message: '（旅行前は0）を入力してください' }
  end
end
