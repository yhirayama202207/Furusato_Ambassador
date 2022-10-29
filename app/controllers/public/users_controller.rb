class Public::UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = current_user
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の編集が完了しました"
      redirect_to user_show_path(current_user)
    else
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def unsubscribe
    @user = current_user
    if @user.update(is_deleted: true)
      reset_session
      #flash[:notice] = "退会が完了しました"
      redirect_to homes_top_path
    else
      render :confirm
    end
  end

  #投稿データのストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:user_name, :home, :hometown, :email, :is_deleted)
  end

end
