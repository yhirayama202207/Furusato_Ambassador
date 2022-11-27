class Article < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :japan_prefecture
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :foot_prints, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def foot_printed_by?(user)
    foot_prints.exists?(user_id: user.id)
  end

end
