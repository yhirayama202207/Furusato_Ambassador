class Public::NotificationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @japan_areas = JapanArea.all
    @japan_prefectures = JapanPrefecture.all
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications.where.not(sender_id: current_user).page(params[:page]).per(20)
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications.where(is_checked: false).each do |notification|
      notification.is_checked = true
      notification.save!
    end
  end

  def destroy_all
    #通知を全削除
  	@notifications = current_user.passive_notifications.destroy_all
  	redirect_to notifications_path
  end

end
