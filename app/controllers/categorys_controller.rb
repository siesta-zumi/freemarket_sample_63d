class CategorysController < ApplicationController

  before_action :set_parents, only: [:index,:new,:show,:create, :edit]
  before_action :set_brands, only: [:index, :show]

  def index
    @parents = Category.where(ancestry: nil).limit(13)
  end

  def show #カテゴリー一覧表示

    # カテゴリー名
    @category_name = Category.find(params[:id]).name

    # 表示する商品を格納する配列を宣言
    @display_items = []

    # selling_status = 0（出品中）の商品を全て取得
    items = Item.where("selling_status = 0")

    # カテゴリーidをinteger型にキャストして変数に格納しておく
    category_id = (params[:id]).to_i

    # 出品中の全商品の中から自身または親のカテゴリーidがcategory_idと一致するものを@display_itemsに格納する。
    items.each do |item|
      if item.category.id == category_id || item.category.ancestor_ids.include?(category_id)
        @display_items << item
      end
    end

  end

  private
  def set_brands
    @brands = Brand.all
  end
end
