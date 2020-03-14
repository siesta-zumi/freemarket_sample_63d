require 'rails_helper'
describe IdentityInformation do
  describe '#create' do

    # 1. nameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a name, email, password, password_confirmation" do
      user = create(:user)
      identityinformation = build(:identity_information, user_id: user.id)
      expect(identityinformation).to be_valid
    end

  end
end

