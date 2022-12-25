class Public::LikesController < ApplicationController

  def create
    @show = params[:show]
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    like = current_user.likes.new(article_id: article.id)
    like.save
    article.create_notification_like!(current_user)
    #redirect_to request.referer || article_path(article)
  end
  
  def create_show
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    like = current_user.likes.new(article_id: article.id)
    like.save
    article.create_notification_like!(current_user)
    #redirect_to request.referer || article_path(article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    like = current_user.likes.find_by(article_id: article.id)
    like.destroy
    #redirect_to request.referer || article_path(article)
  end
  
  def destroy_show
    @article = Article.find(params[:article_id])
    article = Article.find(params[:article_id])
    like = current_user.likes.find_by(article_id: article.id)
    like.destroy
    #redirect_to request.referer || article_path(article)
  end

end
