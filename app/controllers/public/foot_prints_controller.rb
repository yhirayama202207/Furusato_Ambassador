class Public::FootPrintsController < ApplicationController

  before_action :authenticate_user!

  def create
    @show = params[:show]
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    foot_print = current_user.foot_prints.new(article_id: article.id)
    foot_print.save
    article.create_notification_foot_print!(current_user)
  end

  def destroy
    @show = params[:show]
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    foot_print = current_user.foot_prints.find_by(article_id: article.id)
    foot_print.destroy
  end

end