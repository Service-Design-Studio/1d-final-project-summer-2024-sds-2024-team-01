class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def create
    @message = @chat.messages.build(message_params)
    @message.sender = current_user
    @message.receiver = @chat.applicant == current_user ? @chat.requester : @chat.applicant

    Rails.logger.debug("Message before save: #{@message.inspect}")

    if @message.save
      Rails.logger.debug("Message saved successfully")
      redirect_to chat_path(@chat)
    else
      Rails.logger.debug("Message save failed")
      Rails.logger.debug("Validation errors: #{@message.errors.full_messages.join(", ")}")
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
