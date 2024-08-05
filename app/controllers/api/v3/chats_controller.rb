class Api::V3::ChatsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_chat, only: [:show]

  def index
    if params[:chat_id]
      @chat = Chat.find(params[:chat_id])
      @messages = @chat.messages.includes(:sender).order(:created_at)
    end

    @chats = Chat.joins(:messages)
                 .where("applicant_id = ? OR requester_id = ?", current_user.id, current_user.id)
                 .select('chats.*, MAX(messages.created_at) AS last_message_time')
                 .group('chats.id')
                 .order('last_message_time DESC')
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.includes(:sender).order(:created_at)
    render json: {@chat => @messages}, status: :ok
  end

  private

  def set_chat
    @chat = Chat.find_by(id: params[:id])
    unless @chat && (@chat.applicant_id == current_user.id || @chat.requester_id == current_user.id)
      render json: {error: "Chat not found or you don't have permission to access it."}, status: :not_found
    end
  end
end
