class OrdersController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
  end

  def show
    @item = Item.find(params[:id])
    @address = User.find(current_user.id).shipping_address
    @order = Order.new #order_params用に用意
  end

  def create
    #####oedersテーブルに登録#############################################
    order = Order.new(user_id: order_params[:user_id], item_id: order_params[:item_id])
    order.save

    #####購入した商品のselling_statusを(1 売り切れ)に変更#####################
    purchase_item = Item.find(order_params[:item_id])
    purchase_item.selling_status = 1
    purchase_item.save

    ####Payjpに購入情報を送信#########################
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # 登録した顧客IDの定義
    customer_id = current_user.card.customer_id
    charge = Payjp::Charge.create(
    # 金額
    amount: order_params[:item_price],
    # 通貨の種類 日本円なのでjpy
    currency: 'jpy',
    # トークンIDもしくは顧客IDは必須なので顧客IDを指定
    customer: customer_id,
    )

    redirect_to root_path  ##トップページに遷移

  end

  private

  def order_params
    params.require(:order).permit(:item_id, :item_price).merge(user_id:current_user.id)
  end

end
