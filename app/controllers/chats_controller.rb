class ChatsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chat, only: :show
    
    def index
        @chats = Chat.where("applicant_id = ? OR requester_id = ?", current_user.id, current_user.id)
    
        # Extract unique user ids for chat participants other than the current user
        participant_ids = @chats.map do |chat|
            chat.applicant_id == current_user.id ? chat.requester_id : chat.applicant_id
        end.uniq

        # Fetch the user objects for participants
        @participants = User.where(id: participant_ids)

    end 

    def create
        # Logic to create a new chat between two users
    end

    def show
        @chat = Chat.find(params[:id])
        @messages = @chat.messages.order(:created_at)
    end

    def update
        # Logic to update a chat between two users
    end

    def destroy
        # Logic to delete a chat between two users
    end

    private

    def set_chat
        @chat = Chat.find(params[:id])
    end
end