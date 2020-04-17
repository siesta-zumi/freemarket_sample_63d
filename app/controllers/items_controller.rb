class ItemsController < ApplicationController

  before_action :set_parents, only: [:index,:new,:show,:create, :edit, :preview]
  before_action :authenticate_user!, only: [:new, :show] #ログインしていないユーザーはnewとshowアクションの前にログイン画面に遷移
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  PER = 6
  def index
    @items = Item.where(selling_status: 0).page(params[:page]).per(PER).order('created_at DESC')
    @q = Item.ransack(params[:q])
    @brands = Brand.all
  end

  def new
    #出品前に本人確認情報が登録されているか確認、されていなければ登録ページへリダイレクト
    if user_signed_in? && current_user.identity_information.blank?
      redirect_to new_identity_information_path
    end
    @item = Item.new
  end

  def show
    @message = Message.new
    @messages = @item.messages.includes(:user)
    @category = Category.find(@item.category_id)
    @brands = Brand.all
    @brand = @brands.find(@item.brand_id)
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
    @category = Category.find(@item.category_id)
  end

  def update

    # 元々の画像を全削除かつ追加画像の投稿なしの場合、編集画面にリダイレクトさせる
    if item_params[:item_image_ids] != nil && @item.item_images.length == item_params[:item_image_ids].length && item_params[:item_images] == nil
      redirect_to edit_item_path(@item.id), notice: "商品を編集できませんでした"
      return
    end

    # item_paramsの中身を変数に格納する
    item_params_variable = item_params

    # item_paramsの中のitem_image_ids（削除する画像のid）を取得する。
    delete_image_ids = item_params_variable[:item_image_ids]

    # @itemにアタッチされている画像を削除する
    unless delete_image_ids == nil
      delete_image_ids.each do |delete_image_ids|
        @item.item_images.find(delete_image_ids).purge
      end
    end

    # item_params_variableから不要なitem_image_ids（削除する画像のid）
    item_params_variable.delete("item_image_ids")

    # 更新を実行する。 更新に失敗した場合は商品編集画面へリダイレクトさせる
    redirect_to edit_item_path(@item.id), notice: "商品を編集できませんでした" unless @item.update(item_params_variable)

  end

  def destroy
    @item.destroy
    unless @item.destroy
       render item_path
    end
  end

  def preview
    @items = Item.where(selling_status: 0).order('created_at DESC')
    @brands = Brand.all
    @item = Item.find_by(params[:id])
  end
  
  def search
    @categories = Category.where(ancestry: params[:id])
    respond_to do |format|
      format.json
    end
  end

  private
  def item_params
    params.require(:item).permit(:name,:description,:status,:is_bear_shipping_cost,:region,:period,:price,:selling_status,:category_id,:brand_id,item_images: [], item_image_ids: []).merge(user_id:current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end