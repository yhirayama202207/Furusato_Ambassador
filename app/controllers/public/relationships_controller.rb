class Public::RelationshipsController < ApplicationController

  before_action :authenticate_user!

    # フォローするとき
  def create
    following = current_user.relationships.build(follower_id: params[:user_id])
    following.save
    following.create_notification_follow!(current_user, params[:user_id])
    redirect_to request.referer || root_path
  end
  # フォローを外すとき
  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referer || root_path
  end


  # ストロングパラメータ
  private

  def relationship_params
    params.require(:relationship).permit(:user_id, :following_id, :follower_id)
  end
end