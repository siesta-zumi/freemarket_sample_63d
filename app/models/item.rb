class Item < ApplicationRecord

  has_many :item_images
  belongs_to :user
  accepts_nested_attributes_for :item_images, allow_destroy: true
  validates :price, presence: true
end
