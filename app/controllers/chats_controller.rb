class ChatsController < ApplicationController
  before_action :authenticate_user!
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

  # def show
  #   @messages = @chat.messages.includes(:sender).order(:created_at)
  #   @chats = Chat.joins(:messages)
  #                .where("applicant_id = ? OR requester_id = ?", current_user.id, current_user.id)
  #                .select('chats.*, MAX(messages.created_at) AS last_message_time')
  #                .group('chats.id')
  #                .order('last_message_time DESC')
  #   respond_to do |format|
  #     format.html { render :show }
  #     format.js { render partial: 'chat_content', locals: { chat: @chat, messages: @messages } }
  #   end
  # end
  def show
    @messages = @chat.messages.includes(:sender).order(:created_at)
    respond_to do |format|
      format.html
      format.js { render partial: 'chat_content', locals: { chat: @chat, messages: @messages } }
    end
  end

  private

  def set_chat
    @chat = Chat.find_by(id: params[:id])
    unless @chat && (@chat.applicant_id == current_user.id || @chat.requester_id == current_user.id)
      flash[:alert] = "Chat not found or you don't have permission to access it."
      redirect_to chats_path
    end
  end
end
