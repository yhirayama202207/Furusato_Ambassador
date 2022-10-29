class Public::UsersController < ApplicationController

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def unsubscribe
  end

  #投稿データのストロングパラメータ
  private

  def customer_params
    params.require(:user).permit(:user_name, :home, :hometown, :email, :is_deleted)
  end

end
