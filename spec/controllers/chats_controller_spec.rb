require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:chat) { create(:random_chat, applicant: user, requester: other_user) }
  let!(:message) { create(:random_message, chat:, sender: user) }
  let!(:other_chat) { create(:random_chat, applicant: other_user, requester: create(:user)) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    context 'when chat_id is provided' do
      it 'assigns the requested chat to @chat and messages to @messages' do
        get :index, params: { chat_id: chat.id }
        expect(assigns(:chat)).to eq(chat)
        expect(assigns(:messages)).to eq(chat.messages.order(:created_at))
      end
    end

    context 'when chat_id is not provided' do
      it 'assigns all chats involving the current user to @chats' do
        get :index
        expect(assigns(:chats)).to include(chat)
        expect(assigns(:chats)).not_to include(other_chat)
      end
    end
  end

  describe 'GET #show' do
    context 'when the chat exists and belongs to the user' do
      it 'assigns the requested chat to @chat and messages to @messages' do
        get :show, params: { id: chat.id }
        expect(assigns(:chat)).to eq(chat)
        expect(assigns(:messages)).to eq(chat.messages.order(:created_at))
      end

      it 'renders the :show template' do
        get :show, params: { id: chat.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when the chat does not exist or the user does not have access' do
      it 'redirects to the chats index with an alert' do
        get :show, params: { id: other_chat.id }
        expect(flash[:alert]).to eq("Chat not found or you don't have permission to access it.")
        expect(response).to redirect_to(chats_path)
      end
    end
  end
end
