class ItemsController < ApplicationController
  before_action :set_parents, only: [:index,:new,:show,:create]
  before_action :authenticate_user!, only: [:new] #ログインしているユーザーだけ出品画面に遷移できる
  PER = 6
  def index
    @items = Item.where(selling_status: 0).page(params[:page]).per(PER).order('created_at DESC')
  end

  def new
    @item = Item.new
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
  def search
    respond_to do |format|
      format.html
      format.json do
       @children = Category.find(params[:parent_id]).children
       
      end
    end
  end

  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:is_bear_shipping_cost,:region,:period,:price,:selling_status,:category_id,:brand_id,item_images: []).merge(user_id:current_user.id)
  end

end
