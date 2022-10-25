class Admin::JapanAreasController < ApplicationController

  before_action :authenticate_admin!

  def index
  end

  def create
  end

  def edit
  end

  def update
  end

  #投稿データのストロングパラメータ
  private

  def japan_area_params
    params.require(:japan_area).permit(:name)
  end

end