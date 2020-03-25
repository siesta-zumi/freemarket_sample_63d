class MessagesController < ApplicationController
  def create
    # binding.pry
    @message = Message.create(message_params)
    if @message.save
      # redirect_to item_path(message_params[:item_id])
      respond_to do |format|
        format.html { redirect_to item_messages_path, notice: "メッセージを送信しました" }
        format.json
      end
    else 
      redirect_to item_path(message_params[:item_id]),notice: 'メッセージを入力して下さい!!'
    end
  end

  private
  def message_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
