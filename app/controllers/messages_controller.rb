class MessagesController < ApplicationController
  def create
    @message = Message.create(message_params)
    if @message.save
      redirect_to "/items/#{@message.item.id}"
    else 
      redirect_to "/items/#{@message.item.id}",notice: 'メッセージを入力して下さい!!'
    end
  end

  private
  def message_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
