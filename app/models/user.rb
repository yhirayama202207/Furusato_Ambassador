class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :articles
  has_many :comments

  # フォローする
  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  #フォロー一覧用
  has_many :followings, through: :relationships, source: :follower

  #フォローされる
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  #フォロワー一覧用
  has_many :followers, through: :reverse_of_relationships, source: :following

  # フォローしているか判定
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

end
