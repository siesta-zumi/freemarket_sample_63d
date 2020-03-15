class ChangeDataPhoneNumberToIdentityInformations < ActiveRecord::Migration[5.2]
  def change
    change_column :shipping_addresses, :phone_number, :string
  end
end
