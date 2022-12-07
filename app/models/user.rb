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

  has_many :active_notifications, class_name: "Notification", foreign_key: "sender_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "receiver_id", dependent: :destroy

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

  #ユーザー検索機能
  def self.search(search)
    if search != ""
      return Article.all unless search
      User.where(["user_name LIKE(?) OR email LIKE(?) OR home LIKE(?) OR hometown LIKE(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    end
  end

  #ゲストログイン機能
  def self.guest
    find_or_create_by!(user_name: 'ゲスト' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲスト"
    end
  end

end
