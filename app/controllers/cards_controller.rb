class CardsController < ApplicationController
  protect_from_forgery :except => [:pay, :create]
  before_action :set_payjp_api_key, only: [:pay, :create]

  require "payjp"

  def new
    #binding.pry
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end


  def pay #payjpとCardのデータベース作成を実施します。
    
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    #binding.pry
    #Payjp.api_key = 'sk_test_a32bf935b508c9513c1e55fd'
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      #description: '登録テスト', #なくてもOK
      #email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      #binding.pry
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #Payjp.api_key = 'sk_test_a32bf935b508c9513c1e55fd'
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    #binding.pry
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #Payjp.api_key = 'sk_test_a32bf935b508c9513c1e55fd'
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  private

  def set_payjp_api_key
    Payjp.api_key = 'sk_test_a32bf935b508c9513c1e55fd'
  end
end
