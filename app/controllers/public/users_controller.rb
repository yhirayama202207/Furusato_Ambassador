class Public::UsersController < ApplicationController

  before_action :authenticate_user!

  # 全ユーザー一覧
  def index
    @users = User.all.page(params[:page])
  end

  # フォローしているユーザー一覧
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page])
  end

  # フォロワー一覧
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @user_articles = @user.articles.all
    else
      @user_articles = @user.articles.where(is_active: true)
    end
  end

  def mypage
    @user = User.find(params[:id])
    @user_articles = @user.articles.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報の更新が完了しました"
      redirect_to user_path(@user.id)
    end
  end

  #投稿データのストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :home, :hometown, :is_deleted, :image, :following_id, :follower_id)
  end

end