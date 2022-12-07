class Relationship < ApplicationRecord
  # class_name: "User"でUserモデルを参照
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  #フォロー通知機能
  def create_notification_follow!(current_user, user_id)
    temp = Notification.where(["sender_id = ? and receiver_id = ? and action = ? ",current_user.id, user_id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        receiver_id: user_id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end

end
