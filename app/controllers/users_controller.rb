class UsersController < ApplicationController
  before_action :set_user, only: [:show] 
  before_action :set_parents, only: [:index,:new,:show] #applicationControllerを継承しているのでこのコントローラで定義しなくてもset_paramsメソッドは使えます。

  def show
    @items = @user.items
  end


  private 
  
  def set_user
    @user = User.find(params[:id])
  end
end