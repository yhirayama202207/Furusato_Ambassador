class Public::FootPrintsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    foot_print = current_user.foot_prints.new(article_id: article.id)
    foot_print.save
    article.create_notification_foot_print!(current_user)
   # redirect_to request.referer || article_path(article)
  end

  def create_show
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    foot_print = current_user.foot_prints.new(article_id: article.id)
    foot_print.save
    article.create_notification_foot_print!(current_user)
   # redirect_to request.referer || article_path(article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    foot_print = current_user.foot_prints.find_by(article_id: article.id)
    foot_print.destroy
    #redirect_to request.referer || article_path(article)
  end

end
