class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @users = User.all.page(params[:page])
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    @user_articles = @user.articles.all
  end

  def edit
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報の更新が完了しました"
      redirect_to admin_user_path(@user.id)
    end
  end

  def search
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @users = User.search(params[:keyword]).page(params[:page])
  end

  def user_articles
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    @user_articles = @user.articles.all
  end

  #投稿データのストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :home, :hometown, :is_deleted, :image)
  end

end