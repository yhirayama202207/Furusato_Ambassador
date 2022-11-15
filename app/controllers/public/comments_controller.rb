class Public::CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.article_id = params[:article_id]
    if @comment.save
      flash[:notice] = "新規コメント投稿が完了しました。"
      redirect_to article_path(@comment.article.id)
    else
      redirect_to article_path(@comment.article.id)
    end
  end

  # 投稿データのストロングパラメータ
  private

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :comment, :image)
  end

end
