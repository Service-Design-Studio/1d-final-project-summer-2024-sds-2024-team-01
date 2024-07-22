class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def create
    @message = @chat.messages.build(message_params)
    @message.sender = current_user
    @message.receiver = @chat.applicant == current_user ? @chat.requester : @chat.applicant

    if @message.save
      respond_to do |format|
        format.js
      end
    else
      @messages = @chat.messages.order(:created_at)
      render 'chats/show'
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Chat not found."
    redirect_to chats_path
  end

  def message_params
    params.require(:message).permit(:message_text)
  end
end
