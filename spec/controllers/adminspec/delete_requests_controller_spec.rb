# # spec/controllers/admin/delete_requests_controller_spec.rb

# require 'rails_helper'

# RSpec.describe Admin::DeleteRequestsController, type: :controller do
#   let(:admin) { create(:user, :admin) }
#   let(:user) { create(:user) }
#   let!(:request) { create(:request, user: user) }

#   before do
#     sign_in admin
#     allow(RequestMailer).to receive_message_chain(:with, :request_deleted, :deliver_now)
#   end

#   describe 'GET #index' do
#     it 'returns a success response' do
#       get :index
#       expect(response).to be_successful
#       expect(assigns(:requests)).to eq([request])
#     end
#   end

#   describe 'GET #confirm' do
#     it 'returns a success response' do
#       get :confirm, params: { id: request.id }
#       expect(response).to be_successful
#       expect(assigns(:request)).to eq(request)
#     end
#   end

#   describe 'DELETE #destroy' do
#     context 'when the request is successfully deleted' do
#       it 'destroys the requested request and sends an email' do
#         expect {
#           delete :destroy, params: { id: request.id, reason: 'Violation of terms' }
#         }.to change(Request, :count).by(-1)

#         expect(response).to redirect_to(requests_path)
#         expect(flash[:notice]).to eq('Request was successfully deleted.')

#         # Verify email was sent
#         expect(RequestMailer).to have_received(:with).with(user: user, request: request, reason: 'Violation of terms')
#       end
#     end

#     context 'when the request deletion fails' do
#       before do
#         allow_any_instance_of(Request).to receive(:destroy).and_return(false)
#       end

#       it 'does not destroy the requested request and shows an alert' do
#         expect {
#           delete :destroy, params: { id: request.id, reason: 'Violation of terms' }
#         }.not_to change(Request, :count)

#         expect(response).to redirect_to(admin_delete_requests_url)
#         expect(flash[:alert]).to eq('Failed to delete the request.')
#       end
#     end
#   end

#   describe 'authentication and authorization' do
#     context 'when a non-admin user is signed in' do
#       before do
#         sign_out admin
#         sign_in user
#       end

#       it 'redirects to the root path for index' do
#         get :index
#         expect(response).to redirect_to(root_path)
#       end

#       it 'redirects to the root path for confirm' do
#         get :confirm, params: { id: request.id }
#         expect(response).to redirect_to(root_path)
#       end

#       it 'redirects to the root path for destroy' do
#         delete :destroy, params: { id: request.id, reason: 'Violation of terms' }
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end

#   describe 'when no user is signed in' do
#     before do
#       sign_out admin
#     end

#     it 'redirects to the login page for index' do
#       get :index
#       expect(response).to redirect_to(new_user_session_path)
#     end

#     it 'redirects to the login page for confirm' do
#       get :confirm, params: { id: request.id }
#       expect(response).to redirect_to(new_user_session_path)
#     end

#     it 'redirects to the login page for destroy' do
#       delete :destroy, params: { id: request.id, reason: 'Violation of terms' }
#       expect(response).to redirect_to(new_user_session_path)
#     end
#   end
# end
