require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#chat_path_with_request_and_user' do
    let(:request) { create(:request) }
    let(:user) { create(:user) }
    let(:current_user) { create(:user) }

    context 'when current_user is nil' do
      before { allow(helper).to receive(:current_user).and_return(nil) }

      it 'returns the new_user_session_path' do
        expect(helper.chat_path_with_request_and_user(request, user, true)).to eq(new_user_session_path)
      end
    end

    context 'when current_user is not nil' do
      before { allow(helper).to receive(:current_user).and_return(current_user) }

      context 'when current_user_is_requester is true' do
        it 'creates a chat with the current_user as requester and user as applicant' do
          expect do
            path = helper.chat_path_with_request_and_user(request, user, true)
            chat = Chat.find_by(request_id: request.id, applicant_id: user.id, requester_id: current_user.id)
            expect(chat).not_to be_nil
            expect(path).to eq(chats_path(chat_id: chat.id))
          end.to change { Chat.count }.by(1)
        end
      end

      context 'when current_user_is_requester is false' do
        it 'creates a chat with the current_user as applicant and user as requester' do
          expect do
            path = helper.chat_path_with_request_and_user(request, user, false)
            chat = Chat.find_by(request_id: request.id, applicant_id: current_user.id, requester_id: user.id)
            expect(chat).not_to be_nil
            expect(path).to eq(chats_path(chat_id: chat.id))
          end.to change { Chat.count }.by(1)
        end
      end
    end
  end
end
