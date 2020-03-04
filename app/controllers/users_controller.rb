class UsersController < ApplicationController

  before_action :set_parents, only: [:index,:new,:show] #applicationControllerを継承しているのでこのコントローラで定義しなくてもset_paramsメソッドは使えます。

  def show
    @user = User.find(params[:id])
    @items = @user.items
  end
  
end