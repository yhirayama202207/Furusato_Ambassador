class Admin::JapanPrefecturesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @japan_prefecture = JapanPrefecture.new
    @japan_prefectures = JapanPrefecture.all
    @japan_areas = JapanArea.all
  end

  def create
    @japan_prefecture = JapanPrefecture.new(japan_prefecture_params)
    if @japan_prefecture.save
      flash[:notice] = "都道府県登録が完了しました"
      redirect_to admin_japan_prefectures_path
    end
  end

  def edit
    @japan_prefecture = JapanPrefecture.find(params[:id])
    @japan_prefectures = JapanPrefecture.all
    @japan_areas = JapanArea.all
  end

  def update
    @japan_prefecture = JapanPrefecture.find(params[:id])
    if @japan_prefecture.update(japan_prefecture_params)
      flash[:notice] = "都道府県名変更が完了しました"
      redirect_to admin_japan_prefectures_path
    else
      render :edit
    end
  end

  def destroy
    @japan_prefecture = JapanPrefecture.find(params[:id])
    @japan_prefecture.destroy
    redirect_to admin_japan_prefectures_path
  end

  #投稿データのストロングパラメータ
  private

  def japan_prefecture_params
    params.require(:japan_prefecture).permit(:name, :name_english, :japan_area_id)
  end
end
