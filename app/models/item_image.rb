class ItemImage < ApplicationRecord
<<<<<<< HEAD
  mount_uploader :image, ImageUploader
=======

  mount_uploader :src,image, ImageUploader
>>>>>>> 9f7a493273cfcb7d34c534092b09ce5eeb42c7ba
  belongs_to :item, optional: true

end
