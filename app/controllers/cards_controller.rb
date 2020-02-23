class CardsController < ApplicationController
  before_action :set_card, only: [:new, :delete, :show]
  require "payjp"

  def new
    redirect_to action: "show" if !@card.blank? #変数@cardに情報が入っていた場合、確認画面用のshowアクションにリダイレクト
  end

  def pay #payjpとCardsテーブルに登録を行うアクション
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create( #顧客idの作成を行う
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if card.save               #Cardsテーブルに登録
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #payjpとCardsテーブルから削除を行うメソッド
    if !@card.blank?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to action: "new"
  end

  def show #カードのデータpayjpに送り情報を取り出します
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first #Cardsテーブルからユーザーidに紐づいたカード情報を取得
  end

end
