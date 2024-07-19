class ChatsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chat, only: :show
  
    def index
      @chats = Chat.where("applicant_id = ? OR requester_id = ?", current_user.id, current_user.id)
      participant_ids = @chats.map do |chat|
        chat.applicant_id == current_user.id ? chat.requester_id : chat.applicant_id
      end.uniq
      @participants = User.where(id: participant_ids)
    end
  
    def show
      @messages = @chat.messages.order(:created_at)
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
  