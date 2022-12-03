class Article < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :japan_prefecture
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :foot_prints, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :nortifications, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def foot_printed_by?(user)
    foot_prints.exists?(user_id: user.id)
  end

  def clipped_by?(user)
    clips.exists?(user_id: user.id)
  end

  #通知機能（いいね／行った！／クリップ）
  def create_nortification_like!(current_user)
    #すでに「いいね」されているか検索
    temp = Nortification.where(["sender_id = ? and receiver_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, "like"])
    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      nortification = current_user.active_nortifications.new(
        article_id: id,
        sender_id: user_id,
        action: "like"
      )
      #自分の投稿に対するいいねの場合は、通知済みとする
      if nortification.sender_id == nortification.receiver_id
        nortification.checked = true
      end
      nortification.save if nortification.valid?
    end
  end

  def create_nortification_foot_print!(current_user)
    #すでに「行った！」されているか検索
    temp = Nortification.where(["sender_id = ? and receiver_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, "foot_print"])
    #行った！されていない場合のみ、通知レコードを作成
    if temp.blank?
      nortification = current_user.active_nortifications.new(
        article_id: id,
        sender_id: user_id,
        action: "foot_print"
      )
      #自分の投稿に対する行った！の場合は、通知済みとする
      if nortification.sender_id == nortification.receiver_id
        nortification.checked = true
      end
      nortification.save if nortification.valid?
    end
  end

  def create_nortification_clip!(current_user)
    #すでに「クリップ」されているか検索
    temp = Nortification.where(["sender_id = ? and receiver_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, "clip"])
    #クリップされていない場合のみ、通知レコードを作成
    if temp.blank?
      nortification = current_user.active_nortifications.new(
        article_id: id,
        sender_id: user_id,
        action: "clip"
      )
      #自分の投稿に対するクリップの場合は、通知済みとする
      if nortification.sender_id == nortification.receiver_id
        nortification.checked = true
      end
      nortification.save if nortification.valid?
    end
  end

  #通知機能（コメント）
  def create_nortification_comment!(current_user, comment_id)
    #自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_nortification_comment!(current_user, comment_id, temp_id["user_id"])
    end
    #まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_nortification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_nortification_comment!(current_user, comment_id, receiver_id)
    #コメントは複数回することが考えられるため、1つの投稿に複数回通知する
    nortification = current_user.active_nortifications.new(
      post_id: id,
      comment_id: comment_id,
      receiver_id: receiver_id,
      action: "comment"
    )
    #自分の投稿に対するコメントの場合は、通知済みとする
    if nortification.sender_id == nortification.receiver_id
      nortification.checked = true
    end
    nortification.save if nortification.valid?
  end

end
