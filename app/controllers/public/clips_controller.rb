class Public::ClipsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    clip = current_user.clips.new(article_id: article.id)
    clip.save
    article.create_notification_clip!(current_user)
    redirect_to request.referer || article_path(article)
  end

  def destroy
    article = Article.find(params[:article_id])
    clip = current_user.clips.find_by(article_id: article.id)
    clip.destroy
    redirect_to request.referer || article_path(article)
  end

end
