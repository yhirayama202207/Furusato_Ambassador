class Public::ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @japan_prefectures = JapanPrefecture.all
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = "新規記事投稿が完了しました。"
      redirect_to article_path(@article.id)
    else
      @articles = Article.all
      @user = current_user
      render :index
    end
  end

  def index
    @articles = Article.where(is_active: true)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
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
    #@Japan_area_prefectures = @japan_area.japan_prefectures
    #@Japan_area_articles = @Japan_area_prefectures.Article.all.where(is_active: true)
  end

  def search
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @articles = Article.search(params[:keyword])
    @articles_page = Article.all.page(params[:page])
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @article = Article.find(params[:id])
    @user = @article.user
    @comment = @article.comments.build
    @comments = @article.comments.all
  end

  def edit
    @article = Article.find(params[:id])
    @user = current_user
    unless @article.user == current_user
      redirect_to articles_path
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "記事の編集が完了しました"
      redirect_to article_path(@article.id)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to user_path(current_user.id)
  end

  # 投稿データのストロングパラメータ
  private

  def article_params
    params.require(:article).permit(:user_id, :japan_prefecture_id, :region, :name, :title, :address, :latitude, :longitude, :body, :rate, :is_active, :image, tags_attributes: [:name], tag_ids: [])
  end

end