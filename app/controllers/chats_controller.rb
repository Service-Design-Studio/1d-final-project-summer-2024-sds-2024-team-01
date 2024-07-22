class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: :show

  def index
    @chats = Chat.joins(:messages)
                 .where("applicant_id = ? OR requester_id = ?", current_user.id, current_user.id)
                 .select('chats.*, MAX(messages.created_at) AS last_message_time')
                 .group('chats.id')
                 .order('last_message_time DESC')

    participant_ids = @chats.map do |chat|
      chat.applicant_id == current_user.id ? chat.requester_id : chat.applicant_id
    end.uniq
    @participants = User.where(id: participant_ids)
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(:created_at)
    @chats = Chat.joins(:messages)
                 .where("applicant_id = ? OR requester_id = ?", current_user.id, current_user.id)
                 .select('chats.*, MAX(messages.created_at) AS last_message_time')
                 .group('chats.id')
                 .order('last_message_time DESC')
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to @chat
    else
      render :new
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:applicant_id, :requester_id, :request_id)
  end
end
