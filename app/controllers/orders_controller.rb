class OrdersController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
  end

  def show
    @item = Item.find(params[:id])
    @address = User.find(current_user.id).shipping_address
  end

  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # 先ほど登録した顧客IDの定義
    customer_id = current_user.card.customer_id
    charge = Payjp::Charge.create(
    # 金額。今回は固定で3500円としています。
    amount: 3500,
    # 通貨の種類。日本円なのでjpyとします。
    currency: 'jpy',
    # トークンIDもしくは顧客IDは必須なので顧客IDを指定します。
    customer: customer_id,
    )
    redirect_to root_path
  end

end
