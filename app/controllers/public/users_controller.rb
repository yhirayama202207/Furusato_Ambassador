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

    @user_itineraries = @user.itineraries.where(is_active: true).order(created_at: :desc)
    if @user.id == current_user.id
      @user_itineraries = @user.itineraries.all.order(created_at: :desc)
    end

    @user_articles = @user.articles.where(is_active: true).order(created_at: :desc)
    if @user.id == current_user.id
      @user_articles = @user.articles.all.order(created_at: :desc)
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
    else
      @japan_areas = JapanArea.all
      @japan_prefectures = JapanPrefecture.all
      render :edit
    #   redirect_to edit_user_path(@user.id)
    #   flash[:notice] = "ユーザーネームとメールアドレスは必須です。（username and E-mail are required.）"
    end
  end

  # フォローしているユーザー一覧
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page])
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  # フォロワー一覧
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
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
    @user_articles = @user.articles.where(is_active: true).order(created_at: :desc)
    if @user.id == current_user.id
      @user_articles = @user.articles.all.order(created_at: :desc)
    end
  end

  def user_itineraries
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    @user_itineraries = @user.itineraries.where(is_active: true).order(created_at: :desc)
    if @user.id == current_user.id
      @user_itineraries = @user.itineraries.all.order(created_at: :desc)
    end
  end

  def likes
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:article_id)
    #@like_articles = Article.order(created_at: :desc).find(likes)
    @a = []
    @b = []
    Article.find(likes).each do |article|
     if article.user.id == current_user.id
       @a << article
     else
       @b << article if article.is_active
     end
    end
    @like_articles = @a + @b
  end

  def foot_prints
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    foot_prints= FootPrint.where(user_id: @user.id).pluck(:article_id)
    @foot_print_articles = Article.order(created_at: :desc).find(foot_prints)
  end

  def clips
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @user = User.find(params[:id])
    clips= Clip.where(user_id: @user.id).pluck(:article_id)
    @clip_articles = Article.order(created_at: :desc).find(clips)
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
    @user_articles = @user.articles.all.where(is_active: true).order(created_at: :desc)
    likes= Like.where(user_id: @user.id).pluck(:article_id)
    @like_articles = Article.where(is_active: true, id: likes).order(created_at: :desc)
    foot_prints= FootPrint.where(user_id: @user.id).pluck(:article_id)
    @foot_print_articles = Article.where(is_active: true, id: foot_prints).order(created_at: :desc)
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