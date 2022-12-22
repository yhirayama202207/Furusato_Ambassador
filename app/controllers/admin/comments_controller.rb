class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all.order(created_at: :desc)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comment_path
  end

  # 投稿データのストロングパラメータ
  private

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :comment, :image)
  end
end
