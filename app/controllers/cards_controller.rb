class CardsController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id) #Cardsテーブルからユーザーidに紐づいたカードが登録されていた場合取得
    redirect_to action: "show" if card.exists? #変数cardに情報が入っていた場合、確認画面用のshowアクションにリダイレクト
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
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save               #Cardsテーブルに登録
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #payjpとCardsテーブルから削除を行うメソッド
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show #カードのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

end
