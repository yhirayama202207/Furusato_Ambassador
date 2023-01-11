class Admin::ItinerariesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @itineraries = Itinerary.all
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @itinerary = Itinerary.find(params[:id])
    @user = @itinerary.user
    @total = @itinerary.tasks.sum(:price)
    @tasks = @itinerary.tasks
  end

  def update
    @itinerary = Itinerary.find(params[:id])
    if @itinerary.update(itinerary_params)
      flash[:notice] = "旅のしおりの編集が完了しました"
      redirect_to admin_itinerary_path(@itinerary.id)
    else
      render :show
    end
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy
    redirect_to admin_itineraries_path
  end

  # 投稿データのストロングパラメータ
  private

  def itinerary_params
    params.require(:itinerary).permit(:user_id, :title, :comment, :started_at, :finished_at, :rate, :total_payment, :is_active, :image)
  end

end
