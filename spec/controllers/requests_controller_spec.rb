# spec/controllers/requests_controller_spec.rb

require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:request, created_by: user.id).except(:thumbnail).merge(thumbnail: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg'), 'image/jpeg')) }
  let(:invalid_attributes) { attributes_for(:request, title: nil, created_by: user.id) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @requests with requests to user ' do
      request = create(:test_request, created_by: user.id)
      get :index
      expect(assigns(:requests)).to be_present
    end
  end

  describe 'GET #show' do
  #alr have request created
    let(:request) { create(:request, created_by: user.id) }

    it 'returns a success response' do
      get :show, params: { id: request.id }
      
      
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Request' do
        expect {
          post :create, params: { request: valid_attributes }
        }.to change(Request, :count).by(1)
      end

      it 'redirects to the created request' do
        post :create, params: { request: valid_attributes }
        expect(response).to redirect_to(Request.last)
        expect(flash[:notice]).to eq('Request was successfully created.')
      end

      it 'attaches the thumbnail image' do
        post :create, params: { request: valid_attributes }
        expect(Request.last.thumbnail).to be_attached
      end
    end

    context 'with invalid params' do
      it 'renders the new template with unprocessable entity status' do
        post :create, params: { request: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET #edit' do
    let(:request) { create(:request, created_by: user.id) }

    it 'returns a success response' do
      get :edit, params: { id: request.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH/PUT #update' do
    let(:request) { create(:request, created_by: user.id) }
    let(:new_attributes) { { title: 'Updated Title' } }

    context 'with valid params' do
      it 'updates the requested request' do
        patch :update, params: { id: request.id, request: new_attributes }
        request.reload
        expect(request.title).to eq('Updated Title')
      end

      it 'redirects to the request' do
        patch :update, params: { id: request.id, request: new_attributes }
        expect(response).to redirect_to(request)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template with unprocessable entity status' do
        patch :update, params: { id: request.id, request: { title: nil } }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'POST #apply' do
    let(:request) { create(:request) }

    context 'when the user has not applied before' do
      it 'creates a new RequestApplication' do
        expect {
          post :apply, params: { id: request.id }
        }.to change(RequestApplication, :count).by(1)
        expect(RequestApplication.last.applicant_id).to eq(user.id)
        expect(RequestApplication.last.request_id).to eq(request.id)
      end

      it 'redirects to the request with a success notice' do
        post :apply, params: { id: request.id }
        expect(response).to redirect_to(request)
        expect(flash[:notice]).to eq('Successfully applied for the request.')
      end
    end

    # context 'when the user has already applied' do
    #   before do
    #     create(:request_application, applicant_id: user.id, request_id: request.id)
    #   end

    #   it 'does not create a new RequestApplication' do
    #     expect {
    #       post :apply, params: { id: request.id }
    #     }.not_to change(RequestApplication, :count)
    #   end

    #   it 'redirects to the request with an alert' do
    #     post :apply, params: { id: request.id }
    #     expect(response).to redirect_to(request)
    #     expect(flash[:alert]).to eq('You have already applied for this request.')
    #   end
    # end
  end

  describe 'DELETE #destroy' do
    let!(:request) { create(:request, created_by: user.id) }

    it 'destroys the requested request' do
      expect {
        delete :destroy, params: { id: request.id }
      }.to change(Request, :count).by(-1)
    end

    it 'redirects to the requests list' do
      delete :destroy, params: { id: request.id }
      expect(response).to redirect_to(requests_url)
      expect(flash[:notice]).to eq('Request was successfully destroyed.')
    end
  end
end
