class ShippingAddressesController < ApplicationController

  def new
    unless current_user.shipping_address.nil?
      redirect_to edit_shipping_address_path(current_user.id)
    end

    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    if @shipping_address.save
      redirect_to root_path, alert:""
    else
      render new_shipping_address_path, alert:"エラーが発生しました"
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(current_user.shipping_address.id)
  end

  def update
    if current_user.shipping_address.update(shipping_address_params)
      redirect_to user_path(current_user.id), alert:"お届け先情報を更新しました"
    else
      redirect_to edit_shipping_address_path, alert:"エラーが発生しました"
    end
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :prefecture, :municipalities, :block, :building_name_room_number, :phone_number).merge(user_id:current_user.id)
  end

end
