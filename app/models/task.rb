class Task < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :itinerary
  belongs_to :user

  with_options presence: true do
    validates :task, presence: { message: 'を入力してください' }
    validates :started_at, presence: { message: 'を入力してください' }
    validates :finished_at, presence: { message: 'を入力してください' }
    validates :price, presence: { message: '（最低金額￥0～）を入力してください' }
    validates :rate, presence: { message: '（旅行前は0）を入力してください' }
  end
end
