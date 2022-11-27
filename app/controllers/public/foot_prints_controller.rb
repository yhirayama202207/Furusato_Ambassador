class Public::FootPrintsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    foot_print = current_user.foot_prints.new(article_id: article.id)
    foot_print.save
    redirect_to request.referer || article_path(article)
  end

  def destroy
    article = Article.find(params[:article_id])
    foot_print = current_user.foot_prints.find_by(article_id: article.id)
    foot_print.destroy
    redirect_to request.referer || article_path(article)
  end

end
