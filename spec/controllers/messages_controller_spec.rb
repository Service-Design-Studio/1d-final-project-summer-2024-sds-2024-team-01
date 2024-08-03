require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:chat) { create(:random_chat, applicant: user, requester: other_user) }
  let(:valid_attributes) { { message_text: 'Hello, this is a test message!' } }
  let(:invalid_attributes) { { message_text: '' } }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Message' do
        expect do
          post :create, params: { chat_id: chat.id, message: valid_attributes }, format: :json
        end.to change(Message, :count).by(1)
      end

      it 'assigns the correct sender and receiver' do
        post :create, params: { chat_id: chat.id, message: valid_attributes }, format: :json
        message = Message.last
        expect(message.sender).to eq(user)
        expect(message.receiver).to eq(other_user)
      end

      it 'renders the created message as JSON' do
        post :create, params: { chat_id: chat.id, message: valid_attributes }, format: :json
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Message' do
        expect do
          post :create, params: { chat_id: chat.id, message: invalid_attributes }, format: :json
        end.to change(Message, :count).by(0)
      end

      it 'renders the errors as JSON' do
        post :create, params: { chat_id: chat.id, message: invalid_attributes }, format: :json
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'when chat does not exist' do
      it 'redirects to the chats index with an alert' do
        expect do
          post :create, params: { chat_id: 'non_existent_id', message: valid_attributes }
        end.to_not change(Message, :count)

        expect(flash[:alert]).to eq('Chat not found.')
        expect(response).to redirect_to(chats_path)
      end
    end
  end
end
