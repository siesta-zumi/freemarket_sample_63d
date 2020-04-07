class ItemSerchesController < ApplicationController
  before_action :set_parents

  def index
    @q = Item.ransack(search_params)
    @items = @q.result(distinct: true)
  end

  private
  def search_params
    params.require(:q).permit!
  end
  
  
end
