require 'rails_helper'
describe IdentityInformation do
  describe '#create' do

    before do
      @user = create(:user)
    end

    it "is valid with a user_id, first_name, last_name, first_name_furigana, last_name_furigana, birthday" do
      identityinformation = build(:identity_information, user_id: @user.id)
      expect(identityinformation).to be_valid
    end

    it "is valid with a user_id, first_name, last_name, first_name_furigana, last_name_furigana, birthday" do
      identityinformation = build(:identity_information, user_id: @user.id)
      expect(identityinformation).to be_valid
    end

    it "is valid without a user_id" do
      identityinformation = build(:identity_information, user_id: "")
      identityinformation.valid?
      expect(identityinformation.errors[:user]).to include("must exist")
      expect(identityinformation.errors[:user_id]).to include("can't be blank")
    end

    it "is valid without a first_name" do
      identityinformation = build(:identity_information, user_id: @user.id, first_name: "")
      identityinformation.valid?
      expect(identityinformation.errors[:first_name]).to include("can't be blank")
    end

    it "is valid without a last_name" do
      identityinformation = build(:identity_information, user_id: @user.id, last_name: "")
      identityinformation.valid?
      expect(identityinformation.errors[:last_name]).to include("can't be blank")
    end

    it "is valid without a first_name_furigana" do
      identityinformation = build(:identity_information, user_id: @user.id, first_name_furigana: "")
      identityinformation.valid?
      expect(identityinformation.errors[:first_name_furigana]).to include("can't be blank")
    end

    it "is valid without a last_name_furigana" do
      identityinformation = build(:identity_information, user_id: @user.id, last_name_furigana: "")
      identityinformation.valid?
      expect(identityinformation.errors[:last_name_furigana]).to include("can't be blank")
    end

    it "is valid without a birthday" do
      identityinformation = build(:identity_information, user_id: @user.id, birthday: "")
      identityinformation.valid?
      expect(identityinformation.errors[:birthday]).to include("can't be blank")
    end

    it "is valid with a first_name in Hankaku" do
      identityinformation = build(:identity_information, user_id: @user.id, first_name: "ｶﾝﾅｺ")
      identityinformation.valid?
      expect(identityinformation.errors[:first_name]).to include("is invalid")
    end


    it "is valid without a last_name in Hankaku" do
      identityinformation = build(:identity_information, user_id: @user.id, last_name: "ﾊｼﾉﾓﾄ")
      identityinformation.valid?
      expect(identityinformation.errors[:last_name]).to include("is invalid")
    end

    it "is valid without a first_name_furigana" do
      identityinformation = build(:identity_information, user_id: @user.id, first_name_furigana: "ｶﾝﾅｺ")
      identityinformation.valid?
      expect(identityinformation.errors[:first_name_furigana]).to include("is invalid")
    end

    it "is valid without a last_name_furigana" do
      identityinformation = build(:identity_information, user_id: @user.id, last_name_furigana: "ﾊｼﾉﾓﾄ")
      identityinformation.valid?
      expect(identityinformation.errors[:last_name_furigana]).to include("is invalid")
    end

    it "is valid without a first_name_furigana in Kanji" do
      identityinformation = build(:identity_information, user_id: @user.id, first_name_furigana: "環奈子")
      identityinformation.valid?
      expect(identityinformation.errors[:first_name_furigana]).to include("is invalid")
    end

    it "is valid without a last_name_furigana in Kanji" do
      identityinformation = build(:identity_information, user_id: @user.id, last_name_furigana: "橋ノ本")
      identityinformation.valid?
      expect(identityinformation.errors[:last_name_furigana]).to include("is invalid")
    end
  end
end
