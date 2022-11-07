class Article < ApplicationRecord
  has_one_attached :image
  belongs_to :users
  belongs_to :prefectures
end
