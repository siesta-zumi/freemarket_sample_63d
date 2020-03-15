require 'rails_helper'
describe ShippingAddress do
  describe '#create' do

    before do
      @user = create(:user)
    end

    ##成功パターン###############################################
    it "is valid with a user_id, postal_code, prefecture, municipalities, block, building_name_room_number, phone_number" do
      shipping_address = build(:shipping_address, user_id: @user.id)
      expect(shipping_address).to be_valid
    end

    ##必須項目不足パターン###############################################
    it "is valid without a user_id" do
      shipping_address = build(:shipping_address, user_id: nil)
      shipping_address.valid?
      expect(shipping_address.errors[:user]).to include("must exist")
      expect(shipping_address.errors[:user_id]).to include("can't be blank")
    end

    it "is valid without a postal_code" do
      shipping_address = build(:shipping_address, user_id: @user.id, postal_code: "")
      shipping_address.valid?
      expect(shipping_address.errors[:postal_code]).to include("can't be blank")
    end

    it "is valid without a prefecture" do
      shipping_address = build(:shipping_address, user_id: @user.id, prefecture: "")
      shipping_address.valid?
      expect(shipping_address.errors[:prefecture]).to include("can't be blank")
    end

    it "is valid without a municipalities" do
      shipping_address = build(:shipping_address, user_id: @user.id, municipalities: "")
      shipping_address.valid?
      expect(shipping_address.errors[:municipalities]).to include("can't be blank")
    end

    it "is valid without a block" do
      shipping_address = build(:shipping_address, user_id: @user.id, block: "")
      shipping_address.valid?
      expect(shipping_address.errors[:block]).to include("can't be blank")
    end

    ##成功パターン(任意項目空白)###############################################
    it "is valid without a building_name_room_number" do
      shipping_address = build(:shipping_address, user_id: @user.id, building_name_room_number: "")
      expect(shipping_address).to be_valid
    end

    it "is valid without a phone_number" do
      shipping_address = build(:shipping_address, user_id: @user.id, phone_number: "")
      expect(shipping_address).to be_valid
    end

    ##郵便番号、不正文字###############################################
    it "is valid with a phone_number in Not Number" do
      shipping_address = build(:shipping_address, user_id: @user.id, phone_number: "でんわばんごううううう")
      shipping_address.valid?
      expect(shipping_address.errors[:phone_number]).to include("is invalid")
    end

    ##郵便番号桁数不正  （正：7桁）###############################################
    it "is invalid with a postal_code that has less than 6 characters " do
      shipping_address = build(:shipping_address, user_id: @user.id, postal_code: "000000")
      shipping_address.valid?
      expect(shipping_address.errors[:postal_code]).to include("is the wrong length (should be 7 characters)")
    end

    it "is invalid with a postal_code that has less than 8 characters " do
      shipping_address = build(:shipping_address, user_id: @user.id, postal_code: "00000000")
      shipping_address.valid?
      expect(shipping_address.errors[:postal_code]).to include("is the wrong length (should be 7 characters)")
    end

    ##電話番号桁数不正  （正：11~12桁）###############################################
    it "is invalid with a phone_number that has less than 10 characters " do
      shipping_address = build(:shipping_address, user_id: @user.id, phone_number: "0000000000")
      shipping_address.valid?
      expect(shipping_address.errors[:phone_number]).to include("is too short (minimum is 11 characters)")
    end

    it "is invalid with a phone_number that has more than 13 characters " do
      shipping_address = build(:shipping_address, user_id: @user.id, phone_number: "0000000000000")
      shipping_address.valid?
      expect(shipping_address.errors[:phone_number]).to include("is too long (maximum is 12 characters)")
    end

  end
end
