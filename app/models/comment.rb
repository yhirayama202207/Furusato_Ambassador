class Comment < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  with_options presence: true do
    validates :comment, presence: { message: 'を入力してください' }
  end

end
