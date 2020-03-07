class ShippingAddressesController < ApplicationController

  def new
    @shipping_address = ShippingAddress.new
    #binding.pry
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      redirect_to root_path, alert:""
    else
      render new_shipping_address_path, alert:"エラーが発生しました"
    end
  end

  private 

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :prefecture, :municipalities, :block, :building_name_room_number, :phone_number).merge(user_id:current_user.id)
  end

end
