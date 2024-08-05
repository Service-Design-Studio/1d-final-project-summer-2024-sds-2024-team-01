# spec/controllers/my_requests_controller_spec.rb
require 'rails_helper'

RSpec.describe MyRequestsController, type: :controller do
  let!(:user) { create(:random_user) }
  let!(:applicant) { create(:random_user) }
  let!(:request) { create(:request, created_by: user.id) }
  let!(:completed_request) do
    request = FactoryBot.build(:request, created_by: user.id, status: 'Completed', date: Date.yesterday)
    request.save(validate: false)
    request
  end

  let!(:unfulfilled_request) do
    request = FactoryBot.build(:request, created_by: user.id, date: Date.yesterday)
    request.save(validate: false)
    request
  end
  let!(:application) { create(:application, requestid: request.id, userid: applicant.id) }
  let!(:accepted_application) { create(:application, requestid: request.id, userid: applicant.id, status: 'Accepted') }
  let!(:rejected_application) { create(:application, requestid: request.id, userid: applicant.id, status: 'Rejected') }

  before do
    sign_in user
  end

  describe 'GET #index' do
    context 'in HTML' do
      it 'assigns @requests with completed requests created by current_user' do
        get :index, params: { tab: 'completed' }
        expect(assigns(:requests)).to match_array([completed_request])
      end

      it 'assigns @requests with unfulfilled requests created by current_user' do
        get :index, params: { tab: 'unfulfilled' }
        expect(assigns(:requests)).to match_array([unfulfilled_request])
      end

      it 'assigns @requests with in progress requests created by current_user' do
        get :index, params: { tab: 'in_progress' }
        expect(assigns(:requests)).to match_array([request])
      end
    end

    context 'in JSON' do
      it 'assigns @requests with completed requests created by current_user' do
        get :index, params: { tab: 'completed' }, format: :json
        expect(assigns(:requests)).to match_array([completed_request])
      end

      it 'assigns @requests with unfulfilled requests created by current_user' do
        get :index, params: { tab: 'unfulfilled' }, format: :json
        expect(assigns(:requests)).to match_array([unfulfilled_request])
      end

      it 'assigns @requests with in progress requests created by current_user' do
        get :index, params: { tab: 'in_progress' }, format: :json
        expect(assigns(:requests)).to match_array([request])
      end
    end

    it 'assigns @applicants with users who have applied to the requests' do
      get :index
      expect(assigns(:applicants).values).to include(applicant)
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
    context 'if the user does not own the request' do
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

    it 'notifies all the applicants' do
      post :complete, params: { id: request.id }
      expect(Notification.count).to eq(RequestApplication.where(request_id: request.id).where(status: 'Completed').count)
    end
    # Add more specific tests as needed
  end

  describe 'POST #accept' do
    context 'in HTML' do
      it "updates request application status to 'Accepted'" do
        post :accept, params: { id: application.id }
        application.reload
        expect(application.status).to eq('Accepted')
      end
    end
    context 'in JSON' do
      it "updates request application status to 'Accepted'" do
        post :accept, params: { id: application.id }, format: :json
        application.reload
        expect(application.status).to eq('Accepted')
      end
    end
    context 'when the request application fails to save' do
      it "shows 'Failed to accept application' and a 422" do
        allow_any_instance_of(RequestApplication).to receive(:save).and_return(false)
        post :accept, params: { id: application.id }

        expect(application.status).to_not eq('Accepted')
      end
    end
    # Add more specific tests as needed
  end

  describe 'POST #reject' do
    context 'in HTML' do
      it "updates request application status to 'Rejected'" do
        post :reject, params: { id: application.id }
        application.reload
        expect(application.status).to eq('Rejected')
      end
    end
    context 'in JSON' do
      it "updates request application status to 'Rejected'" do
        post :reject, params: { id: application.id }, format: :json
        application.reload
        expect(application.status).to eq('Rejected')
      end
    end

    context 'when the request application fails to save' do
      it "shows 'Failed to reject application' and a 422" do
        allow_any_instance_of(RequestApplication).to receive(:save).and_return(false)
        post :reject, params: { id: application.id }

        expect(application.status).to_not eq('Rejected')
      end
    end
    # Add more specific tests as needed
  end
end
