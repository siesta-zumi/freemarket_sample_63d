class CategorysController < ApplicationController

  before_action :set_parents, only: [:index,:new,:show,:create, :edit]
  before_action :set_brands, only: [:index, :show]

  def index
    @parents = Category.where(ancestry: nil).limit(13)
  end

  def show
    @category_name = Category.find(params[:id]).name

    # paramsで送られてきたcategory_idと一致するかつselling_status=0(出品中)のitemを全件取得
    @items = Item.where("category_id = :selected_category AND selling_status = 0",{selected_category: params[:id]}).page(params[:page]).per(8).order('created_at DESC')
  end

  private
  def set_brands
    @brands = Brand.all
  end
end
