class JapanPrefecture < ApplicationRecord
  belongs_to :japan_area
  has_many :articles
end
