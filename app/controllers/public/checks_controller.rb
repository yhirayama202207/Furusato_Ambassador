class Public::ChecksController < ApplicationController

  def create
    @belonging = Belonging.find(params[:belonging_id])
    belonging = Belonging.find(params[:belonging_id])
    check = current_user.checks.new(belonging_id: belonging.id)
    check.save
    #redirect_to request.referer || article_path(article)
  end

  def destroy
    @belonging = Belonging.find(params[:belonging_id])
    belonging = Belonging.find(params[:belonging_id])
    check = current_user.checks.find_by(belonging_id: belonging.id)
    check.destroy
    #redirect_to request.referer || article_path(article)
  end

end