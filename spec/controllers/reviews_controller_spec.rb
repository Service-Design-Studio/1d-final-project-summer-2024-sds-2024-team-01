require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:request) { create(:request) }
  let(:review) { create(:review, request: request, review_by: user, review_for: create(:user)) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { myrequest_id: request.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:review, review_by: user, review_for: create(:user)) }

    context 'with valid params' do
      it 'creates a new Review' do
        expect {
          post :create, params: { myrequest_id: request.id, review: valid_attributes }
        }.to change(Review, :count).by(1)
      end

      it 'redirects to the created request' do
        post :create, params: { myrequest_id: request.id, review: valid_attributes }
        expect(response).to redirect_to(request)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { myrequest_id: request.id, review: { rating: nil } }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) { { rating: 5 } }

    context 'with valid params' do
      it 'updates the requested review' do
        patch :update, params: { id: review.to_param, review: new_attributes }
        review.reload
        expect(review.rating).to eq(5)
      end

      it 'redirects to the request' do
        patch :update, params: { id: review.to_param, review: new_attributes }
        expect(response).to redirect_to(request_path(review.request))
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        patch :update, params: { id: review.to_param, review: { rating: nil } }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { myrequest_id: request.id, id: review.id }
      expect(response).to be_successful
    end
  end
end

