class Admin::ArticlesController < ApplicationController

  def index
    @articles = Article.where(is_active: true)
    @japan_prefectures = JapanPrefecture.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path
  end

  # 投稿データのストロングパラメータ
  private

  def article_params
    params.require(:article).permit(:user_id, :japan_prefecture_id, :region, :name, :title, :address, :latitude, :longitude, :body, :rate, :is_active, :image)
  end

end
