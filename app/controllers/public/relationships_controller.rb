class Public::RelationshipsController < ApplicationController
    # フォローするとき
  def create
    following = current_user.relationships.build(follower_id: params[:user_id])
    following.save
    redirect_to request.referer || root_path
  end
  # フォローを外すとき
  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referer || root_path
  end
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

  # ストロングパラメータ
  private

  def relationship_params
    params.require(:relationship).permit(:following_id, :follower_id)
  end
end
