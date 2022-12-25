class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  # 全ユーザー一覧
  def index
    @users = User.all.page(params[:page])
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    @user_articles = @user.articles.where(is_active: true)
    if @user.id == current_user.id
      @user_articles = @user.articles.all
    end
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
      redirect_to users_mypage_path(@user.id)
    end
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

  def user_articles
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    # @user = current_user
    # if @user = current_user
    #   @user_articles = @user.articles.all
    # else
    #   @user_articles = @user.articles.where(is_active: true)
    # end
    @user = User.find(params[:id])
    @user_articles = @user.articles.where(is_active: true)
    if @user.id == current_user.id
      @user_articles = @user.articles.all
    end
  end

  def likes
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:article_id)
    @like_articles = Article.find(likes)
  end

  def foot_prints
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    foot_prints= FootPrint.where(user_id: @user.id).pluck(:article_id)
    @foot_print_articles = Article.find(foot_prints)
  end

  def clips
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    clips= Clip.where(user_id: @user.id).pluck(:article_id)
    @clip_articles = Article.find(clips)
  end

  def search
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @users = User.search(params[:keyword]).page(params[:page])
    #@users_page = User.all.page(params[:page])
  end

  def mypage
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = current_user
    @user_articles = @user.articles.all
    likes= Like.where(user_id: @user.id).pluck(:article_id)
    @like_articles = Article.find(likes)
    foot_prints= FootPrint.where(user_id: @user.id).pluck(:article_id)
    @foot_print_articles = Article.find(foot_prints)
    clips= Clip.where(user_id: @user.id).pluck(:article_id)
    @clip_articles = Article.find(clips)
  end

  def confirm
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = current_user
  end

  def unsubscribe
    @user = current_user
    if @user.update(is_deleted: true)
      reset_session
      #flash[:notice] = "退会が完了しました"
      redirect_to homes_top_path
    end
  end

  #投稿データのストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :home, :hometown, :is_deleted, :image, :following_id, :follower_id)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.user_name == "ゲスト"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end