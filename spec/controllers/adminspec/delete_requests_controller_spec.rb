require 'rails_helper'

RSpec.describe Admin::DeleteRequestsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:request_record) { create(:request, user: user) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(assigns(:requests)).to include(request_record)
    end
  end

  describe 'GET #confirm' do
    it 'returns a success response' do
      get :confirm, params: { id: request_record.id }
      expect(response).to be_successful
      expect(assigns(:request)).to eq(request_record)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the request and redirects to requests index with a success notice' do
      expect {
        delete :destroy, params: { id: request_record.id, reason: 'Inappropriate content' }
      }.to change(Request, :count).by(-1)

      expect(response).to redirect_to(requests_path)
      expect(flash[:notice]).to eq('Request was successfully deleted.')
    end

    it 'fails to delete the request and redirects to admin delete requests index with an alert' do
      allow_any_instance_of(Request).to receive(:destroy).and_return(false)

      delete :destroy, params: { id: request_record.id, reason: 'Inappropriate content' }

      expect(response).to redirect_to(admin_delete_requests_url)
      expect(flash[:alert]).to eq('Failed to delete the request.')
    end
  end

  describe 'authorization' do
    it 'redirects non-admin users to root path' do
      sign_out admin
      sign_in user

      get :index
      expect(response).to redirect_to(root_path)

      get :confirm, params: { id: request_record.id }
      expect(response).to redirect_to(root_path)

      delete :destroy, params: { id: request_record.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
