class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    @articles = Article.where(is_active: true)
  end
end
