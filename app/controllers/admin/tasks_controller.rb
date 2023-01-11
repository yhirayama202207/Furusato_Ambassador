class Admin::TasksController < ApplicationController

  before_action :authenticate_admin!

  def index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @tasks = Task.all
  end

  def show
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @task = Task.find(params[:id])
  end

  def destroy
    #@itinerary = Itinerary.find(params[:itinerary_id])
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to admin_itinerary_path(@task.itinerary.id)
    else
      redirect_to admin_itinerary_path(@task.itinerary.id)
    end
  end

  # 投稿データのストロングパラメータ
  private

  def task_params
    params.require(:task).permit(:itinerary_id, :user_id, :task, :started_at, :finished_at, :memo, :way,
                                            :spot, :address, :latitude, :longitude, :price, :rate, :image)
  end
end
