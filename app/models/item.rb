class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :item_images

  ##########ActiveHash####################
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

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
    if !item_images.attached?
      errors.add(:item_images, 'ファイルを添付してください')
    end
  end
end
