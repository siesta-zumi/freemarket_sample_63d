class ItemImage < ApplicationRecord

  mount_uploader :src,image, ImageUploader
  belongs_to :item, optional: true

end
