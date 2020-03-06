class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.references :user,                     null: false, foreign_key: true
      t.integer    :postal_code,              null: false
      t.integer    :prefecture,               null: false
      t.string     :municipalities,           null: false
      t.string     :block,                    null: false
      t.string     :building_name_room_number
      t.integer    :phone_number

      t.timestamps
    end
  end
end
