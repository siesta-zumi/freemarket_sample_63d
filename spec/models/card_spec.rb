require 'rails_helper'
describe Card do
  describe '#create' do

    before do
      @user = create(:user)
    end

    ##成功パターン###############################################
    it "is valid with a user_id, customer_id, card_id" do
      card = build(:card, user_id: @user.id)
      expect(card).to be_valid
    end

    ##必須項目不足パターン###############################################
    it "is valid without a user_id" do
      card = build(:card)
      card.valid?
      expect(card.errors[:user]).to include("must exist")
      expect(card.errors[:user_id]).to include("can't be blank")
    end

    it "is valid without a customer_id" do
      card = build(:card, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("can't be blank")
    end

    it "is valid without a card_id" do
      card = build(:card, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("can't be blank")
    end

  end
end
