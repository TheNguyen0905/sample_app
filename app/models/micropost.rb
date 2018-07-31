class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_by_created_at, -> {order(created_at: :desc)}
  scope :by_user, -> (id) {where(user_id: id)}
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
