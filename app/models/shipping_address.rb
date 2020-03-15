class ShippingAddress < ApplicationRecord
  belongs_to :user

  ###validation####################
  validates :user_id,            presence: true
  validates :postal_code,        presence: true, format: { with: /[0-9０-９]+/ }, length: { is: 7 }
  validates :prefecture,         presence: true
  validates :municipalities,     presence: true
  validates :block,              presence: true
  validates :phone_number,       allow_blank: true, format: { with: /[0-9０-９]+/ }, length: { in: 11..12 }

end


##Colmns##########################
# :user
# :postal_code
# :prefecture
# :municipalities
# :block
# :building_name_room_number
# :phone_number