class JapanArea < ApplicationRecord
  has_many :japan_prefectures
  has_many :articles
end
