class Public::ItinerariesController < ApplicationController

  def new
    @itinerary = Itinerary.new
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @itinerary.user_id = current_user.id
    if @itinerary.save
      redirect_to itinerary_path(@itinerary.id)
    else
      @japan_areas = JapanArea.all
      @japan_prefectures = JapanPrefecture.all
      render :new
    end
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @itinerary = Itinerary.find(params[:id])
    @user = @itinerary.user
    @total = @itinerary.tasks.sum(:price)
    @tasks = @itinerary.tasks
  end

  def edit
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @itinerary = Itinerary.find(params[:id])
    @user = current_user
    unless @itinerary.user == current_user
      redirect_to itineraries_path
    end
  end

  def update
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @itinerary = Itinerary.find(params[:id])
    if @itinerary.update(itinerary_params)
      flash[:notice] = "旅のしおりの編集が完了しました"
      redirect_to itinerary_path(@itinerary.id)
    else
      render :edit
    end
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy
    redirect_to user_itineraries_path(@user.id)
  end

  def index
    @user = current_user
    @itineraries = Itinerary.where(is_active: true).order(created_at: :desc)
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  # 投稿データのストロングパラメータ
  private

  def itinerary_params
    params.require(:itinerary).permit(:user_id, :title, :comment, :started_at, :finished_at, :rate, :total_payment, :is_active, :image)
  end

end
