class Public::TasksController < ApplicationController

  before_action :authenticate_user!

  def new
    @task = Task.new
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
  end

  def create
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @itinerary = Itinerary.find(params[:itinerary_id])
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.itinerary_id = @itinerary.id
    if @task.save
      redirect_to itinerary_path(@task.itinerary.id)
    else
      render :new
    end
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @task = Task.find(params[:id])
  end

  def edit
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @task = Task.find(params[:id])
    @user = current_user
    unless @task.user == current_user
      redirect_to edit_itinerary_task_path(@task.itinerary.id)
    end
  end

  def update
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to itinerary_path(@task.itinerary.id)
    else
      render :edit
    end
  end

  def destroy
    @itinerary = Itinerary.find(params[:itinerary_id])
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to itinerary_path(@task.itinerary.id)
    else
      redirect_to itinerary_path(@task.itinerary.id)
    end
  end

  # 投稿データのストロングパラメータ
  private

  def task_params
    params.require(:task).permit(:itinerary_id, :user_id, :task, :started_at, :finished_at, :memo, :way,
                                            :spot, :address, :latitude, :longitude, :price, :rate, :image)
  end
end
