class Item < ApplicationRecord
  has_many :item_images
  belongs_to :user
end
