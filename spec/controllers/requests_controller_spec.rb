# spec/controllers/requests_controller_spec.rb
require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:user) { create(:random_user) }
  before do
    # No need to attach the avatar here, as we have mocked it in the support file
  end

  describe 'GET #index' do
    it 'returns a success response' do
      sign_in user
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      request = create(:request, created_by: user.id)
      get :show, params: { id: request.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      sign_in user
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #apply' do
    context 'when the user has not applied before' do
      it 'creates a new RequestApplication' do
        sign_in user
        request = create(:request, created_by: user.id)
        post :apply, params: { request_id: request.id }
        expect(
          RequestApplication
            .where(request_id: request.id)
            .count
        ).to eq(1)
      end
    end

    context 'when the user has already applied' do
      it 'does not create a new RequestApplication' do
        sign_in user
        request = create(:request, created_by: user.id)
        post :apply, params: { request_id: request.id }
        post :apply, params: { request_id: request.id }
        expect(
          RequestApplication
            .where(request_id: request.id)
            .count
        ).to eq(1)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Request' do
        sign_in user
        post :create, params: { request: attributes_for(:request, created_by: user.id) }
        expect(Request.count).to eq(1)
      end
    end

    context 'with invalid params' do
      it 'renders the new template with unprocessable entity status' do
        sign_in user
        post :create, params: { request: attributes_for(:request, title: nil) }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid params' do
      it 'updates the requested request' do
        sign_in user
        request = create(:request, created_by: user.id)
        patch :update, params: { id: request.id, request: { title: 'Updated Title' } }
        request.reload
        expect(request.title).to eq('Updated Title')
      end
    end

    context 'with invalid params' do
      it 'renders the edit template with unprocessable entity status' do
        sign_in user
        request = create(:request, created_by: user.id)
        patch :update, params: { id: request.id, request: { title: nil } }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested request' do
      sign_in user
      request = create(:request, created_by: user.id)
      delete :destroy, params: { id: request.id }
      expect(Request.exists?(request.id)).to be_falsey
    end
  end
end
