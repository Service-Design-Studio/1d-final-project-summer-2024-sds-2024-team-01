require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:request) { create(:request) }
  let(:other_request) { create(:request) }
  let(:user_created_request) { create(:request, user: user, status: 'Completed') }
  let(:application) { create(:random_application, status: 'Completed') }
  let(:application_from_someone_else) do
    create(:random_application, status: 'Completed', request: user_created_request)
  end
  let(:review) { create(:reviewrequester, review_by: user, request:) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { request_application_id: application.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_attributes_as_applicant) do
      { rating: 4, review_content: 'Test hehe',
        review_for: application.request.created_by,
        review_by: user.id }
    end
    let(:valid_attributes_as_requester) do
      { rating: 4, review_content: 'Test hehe',
        review_for: application_from_someone_else.applicant_id,
        review_by: user.id }
    end

    context 'as requester reviewing volunteer with valid params' do
      it 'creates a new Review' do
        expect do
          post :create, params: { request_application_id: application.id, review: valid_attributes_as_requester }
        end.to change(Review, :count).by(1)
      end
    end

    context 'as volunteer reviewing requester with valid params' do
      it 'creates a new Review' do
        expect do
          post :create, params: { request_application_id: application_from_someone_else.id, review: valid_attributes_as_applicant }
        end.to change(Review, :count).by(1)
      end
    end

    it 'creates a notification' do
      expect do
        post :create, params: { request_application_id: application.id, review: valid_attributes_as_requester }
      end.to change(Notification, :count).by(1)
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { request_application_id: application.id, review: { rating: nil } }
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
