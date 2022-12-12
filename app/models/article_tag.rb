class ArticleTag < ApplicationRecord
  # has_many :tags, :through => :article_tags, :source => :name
  belongs_to :article
  belongs_to :tag
end
