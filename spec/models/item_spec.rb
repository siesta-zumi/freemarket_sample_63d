require 'rails_helper'
describe Item do
  describe '#create' do

    before do
      @user = create(:user)
    end

    ##成功パターン###############################################
    it "is valid with a name, description, status, is_bear_shipping_cost, region, period, price, selling_status, user_id, category_id, brand_id" do
      item = build(:item, user_id: @user.id)
      expect(item).to be_valid
    end

    ##必須項目不足パターン###############################################
    it "is valid without item_images" do
      item = build(:item, user_id: @user.id)
      item.item_images.purge   #アタッチした画像を削除
      item.valid?
      expect(item.errors[:item_images]).to include("ファイルを添付してください")
    end

    it "is valid without a user_id" do
      item = build(:item, user_id: nil)
      item.valid?
      expect(item.errors[:user]).to include("must exist")
      expect(item.errors[:user_id]).to include("can't be blank")
    end

    it "is valid without a description" do
      item = build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    it "is valid without a status" do
      item = build(:item, status: nil)
      item.valid?
      expect(item.errors[:status]).to include("can't be blank")
    end

    it "is valid without a is_bear_shipping_cost" do
      item = build(:item, is_bear_shipping_cost: nil)
      item.valid?
      expect(item.errors[:is_bear_shipping_cost]).to include("can't be blank")
    end

    it "is valid without a period" do
      item = build(:item, period: nil)
      item.valid?
      expect(item.errors[:period]).to include("can't be blank")
    end

    it "is valid without a selling_status" do
      item = build(:item, selling_status: nil)
      item.valid?
      expect(item.errors[:selling_status]).to include("can't be blank")
    end

    it "is valid without a category_id" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    it "is valid without a brand_id" do
      item = build(:item, brand_id: nil)
      item.valid?
      expect(item.errors[:brand_id]).to include("can't be blank")
    end

  end

end
