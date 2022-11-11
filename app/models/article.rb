class Article < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :japan_prefecture
  has_many :comments
end
