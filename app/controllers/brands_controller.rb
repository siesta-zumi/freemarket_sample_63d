class BrandsController < ApplicationController
  def index
    @brands = Brand.all
    @parents = Category.where(ancestry: nil).limit(13)
  end
end
