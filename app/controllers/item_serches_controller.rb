class ItemSerchesController < ApplicationController
  before_action :set_parents
  before_action :set_brands

  def index
    @q = Item.ransack(search_params)
    @q.sorts = ['update_at desc', 'id desc'] 
    @items = @q.result(distinct: true)
  end

  private
  def search_params
    params.require(:q).permit(:name_cont)
  end

  def set_brands
    @brands = Brand.all
  end
  
end
