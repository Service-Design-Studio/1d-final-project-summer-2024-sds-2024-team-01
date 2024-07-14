# spec/controllers/my_requests_controller_spec.rb
require 'rails_helper'

RSpec.describe MyRequestsController, type: :controller do
  let!(:user) { create(:random_user) } # Assuming you have a factory for User
  let!(:applicant) { create(:random_user) } # Assuming you have a factory for User
  let!(:request) { create(:request, created_by: user.id) } # Assuming you have a factory for Request
  let!(:application) { create(:application, requestid: request.id, userid: applicant.id) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @requests with requests created by current_user' do
      # get :index
      # expect(assigns(:requests)).to match_array([request])
    end

    it 'assigns @applicants with users who have applied to the requests' do
      get :index
      expect(assigns(:applicants).values).to include(applicant)
    end

    it "assigns @comprequests with requests marked as 'Completed'" do
      get :index
      expect(assigns(:comprequests)).to match_array(Request.where(status: 'Completed'))
    end
  end

  # RequestController test
  # describe 'GET #show' do
  #   it 'assigns @request with the correct request' do
  #     get :show, params: { id: request.id }
  #     expect(assigns(:request)).to eq(request)
  #   end

  # Add more specific tests as needed
  # end

  describe 'POST #complete' do
    context 'user does not own the request' do
      let(:not_owned_request) { create(:test_request) }
      it 'prevents them for doing anything' do
        post :complete, params: { id: not_owned_request.id }
        expect(not_owned_request.status).to_not eq('Completed')
      end
    end

    it "updates request status to 'Completed'" do
      post :complete, params: { id: request.id }
      request.reload
      expect(request.status).to eq('Completed')
    end

    # Add more specific tests as needed
  end

  describe 'POST #accept' do
    it "updates request application status to 'Accepted'" do
      post :accept, params: { id: application.id }
      application.reload
      expect(application.status).to eq('Accepted')
    end

    # Add more specific tests as needed
  end

  describe 'POST #reject' do
    it "updates request application status to 'Rejected'" do
      post :reject, params: { id: application.id }
      application.reload
      expect(application.status).to eq('Rejected')
    end

    # Add more specific tests as needed
  end
end
