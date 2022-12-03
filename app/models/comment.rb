class Comment < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :article
  #has_many :nortifications, dependent: :destroy
end
