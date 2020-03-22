class BrandsController < ApplicationController
  def indeex
    @brand = Brand.all
  end
end
