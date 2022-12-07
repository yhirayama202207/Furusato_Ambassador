module Public::NotificationsHelper

  def notification_form(notification)
	  @sender = notification.sender
	  @comment = nil
	  @your_article = link_to 'あなたの投稿', article_path(notification), style:"font-weight: bold;"
	  @sender_comment = notification.comment_id

	  #notification.actionがfollowかlikeかfoot_printかclipかcommentか
	  case notification.action

	    when "follow" then
	      tag.a(notification.sender.user_name, href:user_path(@sender), style:"font-weight: bold;")+"さんがあなたをフォローしました"
	    when "like" then
	      tag.a(notification.sender.user_name, href:user_path(@sender), style:"font-weight: bold;")+"さんが"+tag.a('あなたの投稿'+"「"+notification.article.title+"」", href:article_path(notification.article_id), style:"font-weight: bold;")+"にいいねしました"
	    when "foot_print" then
	      tag.a(notification.sender.user_name, href:user_path(@sender), style:"font-weight: bold;")+"さんが"+tag.a('あなたの投稿'+"「"+notification.article.title+"」", href:article_path(notification.article_id), style:"font-weight: bold;")+"に行った！しました"
	    when "clip" then
	      tag.a(notification.sender.user_name, href:user_path(@sender), style:"font-weight: bold;")+"さんが"+tag.a('あなたの投稿'+"「"+notification.article.title+"」", href:article_path(notification.article_id), style:"font-weight: bold;")+"をクリップしました"
	    when "comment" then
	    	@comment = Comment.find_by(id: @sender_comment)&.comment
	    	tag.a(@sender.user_name, href:user_path(@sender), style:"font-weight: bold;")+"さんが"+tag.a('あなたの投稿'+"「"+notification.article.title+"」", href:article_path(notification.article_id), style:"font-weight: bold;")+"にコメントしました"
	  end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(is_checked: false)
  end

end
