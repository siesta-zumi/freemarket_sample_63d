class Item < ApplicationRecord
  belongs_to :category
  has_many :item_images
  belongs_to :user
  accepts_nested_attributes_for :item_images, allow_destroy: true

end
