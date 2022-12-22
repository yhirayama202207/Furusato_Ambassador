class Admin::ArticlesController < ApplicationController

  def index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @articles = Article.all
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @article = Article.find(params[:id])
    @user = @article.user
    @comment = @article.comments.build
    @comments = @article.comments.all
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

  def prefecture_index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @japan_prefecture = JapanPrefecture.find(params[:id])
    @articles = @japan_prefecture.articles.where(is_active: true)
  end

  def area_index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @japan_prefecture = JapanPrefecture.find(params[:id])
    @japan_area = JapanArea.find(params[:id])
    @articles = Article.where(is_active: true).where(japan_prefecture_id: @japan_area.japan_prefectures.pluck(:id))
  end

  def tag_index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.where(is_active: true)
  end

  # 投稿データのストロングパラメータ
  private

  def article_params
    params.require(:article).permit(:user_id, :japan_prefecture_id, :region, :name, :title, :address, :latitude, :longitude, :body, :rate, :is_active, :image)
  end

end
