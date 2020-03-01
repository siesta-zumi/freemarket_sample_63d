class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :item_images

  ##########validation####################
  validates :name, presence: true
  validates :description, presence: true
  validates :is_bear_shipping_cost, presence: true
  validates :period, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :brand_id, presence: true
  validates :status, presence: true
  validate :image_presence

  def image_presence
    if item_images.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:item_images, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      errors.add(:item_images, 'ファイルを添付してください')
    end
  end
end
