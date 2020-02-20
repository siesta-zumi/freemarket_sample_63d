class ItemsController < ApplicationController
  def index
    # @items=Item.all
    # モデル作成したら復活します
  end

  def new
    @items = Item.new
  end

  def show
  end

  def create
    Item.create(item_params)
  end
  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:is_bear_shipping_cost,:region,:period,:price,:selling_status,:category_id,:brand_id,item_images_attributes: [:image]).marge(user_id:current_user.id)
  end

end
