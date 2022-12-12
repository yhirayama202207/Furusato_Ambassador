class Tag < ApplicationRecord
  # tag削除時、中間テーブルも削除
  # has_many :article_tags, dependent: :destroy
  # has_many :articles, through: :article_tags
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags, dependent: :destroy
  # 空白登録はNG
  validates :name, presence: true
  # 重複登録NG
  validates :name, uniqueness: true
end
