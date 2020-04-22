class UsersController < ApplicationController
  before_action :set_user, only: [:show, :create, :update] 
  before_action :set_parents, only: [:index,:new,:show] #applicationControllerを継承しているのでこのコントローラで定義しなくてもset_paramsメソッドは使えます。



  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path, alert:"登録しました"
    else
      render new_user_path, alert:"登録に失敗しました"
    end
  end

  def show
    @items = @user.items
    @brands = Brand.all

    @ordered_items = []
    @user.orders.each do |order|
      @ordered_items << Item.find(order.item_id)
    end
  end


  def update
    if @user.update(user_params)
       redirect_to user_path
    else
       render new_user_path
    end
  end
 
  private 

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:avatar)
  end

end