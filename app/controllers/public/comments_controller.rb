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

  def edit
    @comment = Comment.find(params[:article_id])
    @user = current_user
    unless @comment.user == current_user
      redirect_to edit_article_comment_path(@comment.article.id)
    end
  end

  def update
    @comment = Comment.find(params[:article_id])
    if @comment.update(comment_params)
      flash[:notice] = "記事の編集が完了しました"
      redirect_to article_path(@comment.article.id)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:article_id])
    @comment.destroy
    redirect_to article_path(@comment.article.id)
  end

  # 投稿データのストロングパラメータ
  private

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :comment, :image)
  end

end
