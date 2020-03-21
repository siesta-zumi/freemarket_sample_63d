class ItemsController < ApplicationController

  before_action :set_parents, only: [:index,:new,:show,:create, :edit]
  before_action :authenticate_user!, only: [:new] #ログインしていないユーザーはnewアクションの前にログイン画面に遷移
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  PER = 6
  def index
    @items = Item.where(selling_status: 0).page(params[:page]).per(PER).order('created_at DESC')
  end

  def new
    #出品前に本人確認情報が登録されているか確認、されていなければ登録ページへリダイレクト
    if user_signed_in? && current_user.identity_information.blank?
      redirect_to new_identity_information_path
    end
    @item = Item.new
  end

  def show
   
    @category = Category.find(@item.category_id)
    @brand = Brand.find(@item.brand_id)
    @status = Status.find(@item.status)
    @cost = IsBearShippingCost.find(@item.is_bear_shipping_cost)
    @region = Prefecture.find(@item.region)
    @period = Period.find(@item.period)
    @items = Item.all
    @like = Like.new
    @items_ids = @items.ids.sort
    current_item_index = @items_ids.index(@item.id)
    @is_first = current_item_index == 0 ? true : false
    @is_last = current_item_index == @items_ids.length - 1 ? true : false

    previous_index = current_item_index - 1
    next_index = current_item_index + 1

    @previous_item_id = @items_ids[previous_index]
    @next_item_id = @items_ids[next_index]
    
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path,alert:"商品出品が完了しました"
    else
      render new_item_path,alert:"エラーが発生しました"
    end
  end

  def edit
  end

  def update
    @item.update!(item_params)
    unless @item.save render edit_item_path, notice: "商品を編集できませんでした"
    end
  end

  def destroy
    @item.destroy
    unless @item.destroy render destroy_item_path, notice: "商品を削除できませんでした"
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

  def set_item
    @item = Item.find(params[:id])
  end

end
