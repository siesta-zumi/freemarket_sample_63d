class ItemsController < ApplicationController
  PER = 6
  def index
    @items = Item.includes(:item_images).order('created_at DESC')
    @itmimgs = ItemImage.page(params[:page]).per(PER).order('created_at DESC')
    
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path,alert:"商品出品が完了しました"
    else
      render new_item_path,alert:"エラーが発生しました"
    end
  end
  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:is_bear_shipping_cost,:region,:period,:price,:selling_status,:category_id,:brand_id,item_images_attributes: [:image]).merge(user_id:current_user.id)
  end
  

end
