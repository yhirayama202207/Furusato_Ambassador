class Admin::ArticlesController < ApplicationController

  def index
    @japan_prefectures = JapanPrefecture.all
    @articles = Article.where(is_active: true)
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "記事の編集が完了しました"
      redirect_to admin_article_path(@article.id)
    else
      render :show
    end
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
