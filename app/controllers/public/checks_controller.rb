class Public::ChecksController < ApplicationController

  def create
    @belonging = Belonging.find(params[:belonging_id])
    belonging = Belonging.find(params[:belonging_id])
    check = current_user.checks.new(belonging_id: belonging.id)
    check.save
  end

  def destroy
    @belonging = Belonging.find(params[:belonging_id])
    belonging = Belonging.find(params[:belonging_id])
    check = current_user.checks.find_by(belonging_id: belonging.id)
    check.destroy
  end

  # def destroy_all
  #   #チェックを全削除
  #   current_user.passive_checks.destroy_all
  # 	redirect_to belongings_path
  # end

end