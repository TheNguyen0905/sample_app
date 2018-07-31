class Micropost < ApplicationRecord
  belongs_to :user
  scope :lastest, -> {order(created_at: :desc)}
  scope :by_user, -> (following_ids, user_id) {where ("user_id IN (:following_ids)
    OR user_id = :user_id"), following_ids: following_ids, user_id: user_id}
  mount_uploader :picture, PictureUploader
  validates :content, presence: true, length:
    {maximum: Settings.micropost_content_maximun}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.size_image.megabytes
      errors.add(:picture, t("model.user.picture_size"))
    end
  end
end
