class Article < ApplicationRecord
  has_many_attached :image
  belongs_to :users
  belongs_to :prefectures
end
