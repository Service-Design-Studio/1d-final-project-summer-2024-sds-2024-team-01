class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def create
    @message = @chat.messages.build(message_params)
    @message.sender = current_user
    @message.receiver = @chat.applicant == current_user ? @chat.requester : @chat.applicant

    if @message.save
      respond_to do |format|
        format.json { render json: @message.to_json(include: :sender), status: :created }
      end
    else
      respond_to do |format|
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
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