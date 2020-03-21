class Order < ApplicationRecord

  belongs_to :user
  belongs_to :item

  ##########validation####################
  validates :user_id, presence: true
  validates :item_id, presence: true

end
