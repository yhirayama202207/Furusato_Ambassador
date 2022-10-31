class Article < ApplicationRecord
  has_many_attached :images
  belongs_to :users
  belongs_to :prefectures
end
