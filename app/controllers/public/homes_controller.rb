class Public::HomesController < ApplicationController
  def top
    @articles = Article.where(is_active: true)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @all_ranks = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(4).pluck(:article_id))
  end

  def about
  end
end
