class IdentityInformationsController < ApplicationController

  def new
    unless current_user.identity_information.nil?
      redirect_to edit_identity_information_path(current_user.id)
    end

    @identity_information = IdentityInformation.new
  end

  def create
    @identity_information = IdentityInformation.new(identity_information_params)
    if @identity_information.save
      redirect_to root_path, alert:"本人確認情報を登録しました"
    else
      render new_identity_information_path, alert:"エラーが発生しました"
    end
  end

  def edit
    @identity_information = IdentityInformation.find(current_user.identity_information.id)
  end

  def update
    if current_user.identity_information.update(identity_information_params)
      redirect_to user_path(current_user.id), alert:"本人確認情報を更新しました"
    else
      redirect_to edit_identity_information_path, alert:"エラーが発生しました"
    end
  end
  private 

  def identity_information_params
    params.require(:identity_information).permit(:first_name, :last_name, :first_name_furigana, :last_name_furigana, :birthday).merge(user_id:current_user.id)
  end

end
