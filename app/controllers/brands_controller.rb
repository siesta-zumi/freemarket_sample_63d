class BrandsController < ApplicationController

  before_action :set_parents, only: [:index, :show]
  before_action :set_brands, only: [:index, :show]

  def index
    @parents = Category.where(ancestry: nil).limit(13)
  end

  def show
    @brand_name = Brand.find(params[:id]).name

    # paramsで送られてきたbrand_idと一致するかつselling_status=0(出品中)のitemを全件取得
    @items = Item.where("brand_id = :selected_brand AND selling_status = 0",{selected_brand: params[:id]}).page(params[:page]).per(8).order('created_at DESC')
  end

  private
  def set_brands
    @brands = Brand.all
  end

end
