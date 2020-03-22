class ItemSerchesController < ApplicationController
  def index
    @q = Item.ransack(search_params)
    @items = @q.result(distinct: true)
  end

  private
  def search_params
    params.require(:q).permit!
  end
end
