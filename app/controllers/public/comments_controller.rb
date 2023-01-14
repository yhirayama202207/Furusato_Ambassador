class Public::CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create
    @hoge = "hoge"
    @article = Article.find(params[:article_id])
    # @comments = @article.comments.order(created_at: :desc)
    @comment = Comment.new(comment_params)
    #@comment = current_user.comments.new(article_id: article.id)
    @comment.user_id = current_user.id
    @comment.article_id = @article.id
    if @comment.save
      @article.create_notification_comment!(current_user, @comment.id)
    else
      render "public/comments/error"
    end
    #   redirect_to article_path(@comment.article.id)
    # else
    #   redirect_to article_path(@comment.article.id)
  end

  def edit
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @comment = Comment.find(params[:id])
    @user = current_user
    unless @comment.user == current_user
      redirect_to edit_article_comment_path(@comment.article.id)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "記事の編集が完了しました"
      redirect_to article_path(@comment.article.id)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    #   redirect_to article_path(@comment.article.id)
    # else
    #   redirect_to article_path(@comment.article.id)
    # end
  end

  # 投稿データのストロングパラメータ
  private

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :comment, :image)
  end

end
