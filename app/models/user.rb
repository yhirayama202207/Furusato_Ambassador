class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :articles
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :foot_prints, dependent: :destroy
  has_many :clips, dependent: :destroy

  has_many :active_nortifications, class_name: "Nortification", foreign_key: "sender_id", dependent: :destroy
  has_many :passive_nortifications, class_name: "Nortification", foreign_key: "receiver_id", dependent: :destroy

  # フォローする
  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  #フォロー一覧用
  has_many :followings, through: :relationships, source: :follower

  #フォローされる
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  #フォロワー一覧用
  has_many :followers, through: :reverse_of_relationships, source: :following

  #フォローしているか判定
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

  #フォロー通知機能
  def create_nortification_follow!(current_user
    temp = Nortification.where(["sender_id = ? and receiver_id = ? and action = ? ",current_user.id, id, "follow"])
    if temp.blank?
      nortification = current_user.active_nortifications.new(
        receiver_id: id,
        action: "follow"
      )
      nortification.save if nortification.valid?
    end
  end

  #ユーザー検索機能
  def self.search(search)
    if search != ""
      User.where(["user_name LIKE(?) OR email LIKE(?) OR home LIKE(?) OR hometown LIKE(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      User.includes(:user).order("created_at DESC")
    end
  end

end
