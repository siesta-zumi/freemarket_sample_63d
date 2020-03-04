class UsersController < ApplicationController
before_action :set_parents, only: [:index,:show]
  def show
    @user = User.find(params[:id])
    @items = @user.items
  end
  
end