# spec/controllers/my_requests_controller_spec.rb

require 'rails_helper'

RSpec.describe MyRequestsController, type: :controller do
  let(:user) { create(:user) }  # Assuming you have a factory for User
  let(:request) { create(:request, created_by: user.id) }  # Assuming you have a factory for Request
  let(:request_application) { create(:request_application, request: request) }  # Assuming you have a factory for RequestApplication

  before { sign_in user }

  describe "GET #index" do
    it "assigns @requests with requests created by current_user" do
      get :index
      expect(assigns(:requests)).to match_array([request])
    end
    
    it "assigns @applicants with users who have applied to the requests" do
      get :index
      expect(assigns(:applicants).values).to include(user)
    end
    
    it "assigns @comprequests with requests marked as 'Completed'" do
      get :index
      expect(assigns(:comprequests)).to match_array(Request.where(status: 'Completed'))
    end
    
    # Add more specific tests as needed
  end
  
  describe "GET #show" do
    it "assigns @request with the correct request" do
      get :show, params: { id: request.id }
      expect(assigns(:request)).to eq(request)
    end
    
    # Add more specific tests as needed
  end
  
  describe "GET #new" do
    it "assigns @request as a new Request object" do
      get :new
      expect(assigns(:request)).to be_a_new(Request)
    end
    
    # Add more specific tests as needed
  end
  
  describe "PATCH #complete" do
    it "updates request status to 'Completed'" do
      patch :complete, params: { id: request.id }
      request.reload
      expect(request.status).to eq("Completed")
    end
    
    # Add more specific tests as needed
  end
  
  describe "PATCH #accept" do
    it "updates request application status to 'Accepted'" do
      patch :accept, params: { id: request_application.id }
      request_application.reload
      expect(request_application.status).to eq("Accepted")
    end
    
    # Add more specific tests as needed
  end
  
  describe "PATCH #reject" do
    it "updates request application status to 'Rejected'" do
      patch :reject, params: { id: request_application.id }
      request_application.reload
      expect(request_application.status).to eq("Rejected")
    end
    
    # Add more specific tests as needed
  end
end

