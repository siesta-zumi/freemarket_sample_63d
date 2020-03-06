class IdentityInformationsController < ApplicationController
  def new
    @identity_information = IdentityInformation.new
    #binding.pry
  end

  def create
    @identity_information = IdentityInformation.new(identity_information_params)
    if @identity_information.save
      redirect_to root_path, alert:"本人確認情報を登録しました"
    else
      render new_item_path, alert:"エラーが発生しました"
    end
  end

  private 

  def identity_information_params
    params.require(:identity_information).permit(:first_name, :last_name, :first_name_furigana, :last_name_furigana, :birthday).merge(user_id:current_user.id)
  end

end
