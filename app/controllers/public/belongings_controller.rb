class Public::BelongingsController < ApplicationController

  def index
    @belonging = Belonging.new
    @belongings = current_user.belongings.all
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def create
    @belonging = Belonging.new(belonging_params)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @belonging.user_id = current_user.id
    if @belonging.save
      redirect_to belongings_path
    else
      @japan_areas = JapanArea.all
      @japan_prefectures = JapanPrefecture.all
      @belongings = current_user.belongings.all
      render :index
    end
  end

  def edit
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @belonging = Belonging.find(params[:id])
    @user = current_user
    unless @belonging.user == current_user
      redirect_to homes_top_path
    end
  end

  def update
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @belonging = Belonging.find(params[:id])
    if @belonging.update(belonging_params)
      flash[:notice] = "持ち物の追加が完了しました"
      redirect_to belongings_path
    else
      render :index
    end
  end

  def destroy
    @belonging = Belonging.find(params[:id])
    @belonging.destroy
    redirect_to belongings_path
  end

  # 投稿データのストロングパラメータ
  private

  def belonging_params
    params.require(:belonging).permit(:user_id, :name)
  end

end