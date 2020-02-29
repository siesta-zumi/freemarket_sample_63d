class Item < ApplicationRecord
  belongs_to :user
  validates :price, presence: true
  has_many_attached :item_images
end
