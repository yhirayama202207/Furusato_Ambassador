class Public::ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :prefecture_index, :area_index]

  def new
    @article = Article.new
    @tags = Tag.all
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def create
    @article = Article.new(article_params)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @article.user_id = current_user.id
    @tag_list = params[:article][:tag_ids].split("、")
    if @article.save
      @article.save_tag(@tag_list)
      redirect_to article_path(@article.id)
    else
      @japan_areas = JapanArea.all
      @japan_prefectures = JapanPrefecture.all
      render :new
    end
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @article = Article.find(params[:id])
    @user = @article.user
  end

  def edit
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @article = Article.find(params[:id])
    @user = current_user
    unless @article.user == current_user
      redirect_to articles_path
    end
  end

  def update
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @article = Article.find(params[:id])
    @tag_list = params[:article][:tag_ids].split("、")
    if @article.update(article_params)
      @article.save_tag(@tag_list)
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

  def index
    @articles = Article.where(is_active: true).order(created_at: :desc)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def prefecture_index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @japan_prefecture = JapanPrefecture.find(params[:id])
    @articles = @japan_prefecture.articles.where(is_active: true).order(created_at: :desc)
  end

  def area_index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @japan_prefecture = JapanPrefecture.find(params[:id])
    @japan_area = JapanArea.find(params[:id])
    @articles = Article.where(is_active: true).where(japan_prefecture_id: @japan_area.japan_prefectures.pluck(:id)).order(created_at: :desc)
  end

  def tag_index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.where(is_active: true).order(created_at: :desc)
  end

  def search
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @articles = Article.search(params[:keyword]).where(is_active: true).order(created_at: :desc)
    @articles_page = Article.all.page(params[:page])
  end


  # 投稿データのストロングパラメータ
  private

  def article_params
    params.require(:article).permit(:user_id, :japan_prefecture_id, :region, :title, :body, :rate,
                          :name, :address, :latitude, :longitude, :is_active, :image, tags_attributes: [:name], tag_ids: [])
  end

end