class ItemsController < ApplicationController
  def index
    # @items=Item.all
    # モデル作成したら復活します
  end

  def new
    @items = Item.new
  end
 
  def show
  end

end
