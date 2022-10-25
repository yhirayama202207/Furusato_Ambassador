class Admin::JapanAreasController < ApplicationController

  before_action :authenticate_admin!

  def index
    @japan_area = JapanArea.new
    @japan_areas = JapanArea.all
  end

  def create
    @japan_area = JapanArea.new(japan_area_params)
    if @japan_area.save
      flash[:notice] = "日本エリア登録が完了しました"
      redirect_to admin_japan_areas_path
    end
  end

  def edit
    @japan_area = JapanArea.find(params[:id])
  end

  def update
    @japan_area = JapanArea.find(params[:id])
    if @japan_area.update(japan_area_params)
      flash[:notice] = "日本エリア名変更が完了しました"
      redirect_to admin_japan_areas_path
    else
      render :edit
    end
  end

  #投稿データのストロングパラメータ
  private

  def japan_area_params
    params.require(:japan_area).permit(:name)
  end

end