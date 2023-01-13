class Belonging < ApplicationRecord
  belongs_to :user
  has_many :checks, dependent: :destroy

  def checked_by?(user)
    if user.present?
      return checks.exists?(user_id: user.id)
    end
    return false
  end

  with_options presence: true do
    validates :name, presence: { message: 'を入力してください' }
  end

end
