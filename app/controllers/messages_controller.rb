class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chat
  
    def create
      @message = @chat.messages.build(message_params)
      @message.sender = current_user
      @message.receiver = @chat.applicant == current_user ? @chat.requester : @chat.applicant
  
      if @message.save
        redirect_to chat_path(@chat)
      else
        render 'chats/show'
      end
    end
  
    private
  
    def set_chat
      @chat = Chat.find(params[:chat_id])
    end
  
    def message_params
      params.require(:message).permit(:message_text, :receiver_id)
    end
  end
  