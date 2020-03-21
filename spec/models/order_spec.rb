require 'rails_helper'
describe Order do
  describe '#create' do

    before do
      @user = create(:user)

      @brand = create(:brand)       #itemの外部キー
      @category = create(:category) #itemの外部キー
      @item = create(:item, user_id: @user.id, brand_id: @brand.id, category_id: @category.id)
    end

    ##成功パターン###############################################
    it "is valid with a user_id, item_id" do
      order = build(:order, user_id: @user.id, item_id: @item.id)
      expect(order).to be_valid
    end

    ##必須項目不足パターン###############################################
    it "is valid without a user_id" do
      order = build(:order, user_id: nil, item_id: @item.id)
      order.valid?
      expect(order.errors[:user_id]).to include("can't be blank")
    end

    it "is valid without a item_id" do
      order = build(:order, user_id: @user.id, item_id: nil)
      order.valid?
      expect(order.errors[:item_id]).to include("can't be blank")
    end

  end
end
