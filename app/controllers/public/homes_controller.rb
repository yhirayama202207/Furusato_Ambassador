class Public::HomesController < ApplicationController
  def top
    @all_ranks = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(4).pluck(:article_id))
    @articles = Article.where(is_active: true).where.not(id: @all_ranks.pluck(:id) )
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def about
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end
end
