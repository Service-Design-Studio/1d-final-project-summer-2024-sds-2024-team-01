# spec/integration/my_requests_controller_spec.rb
require 'rails_helper'

RSpec.describe "MyRequestsController", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:request_record) { create(:request, created_by: user.id) }
  let(:application) { create(:random_application, request: request_record) }

  before do
    sign_in user
  end

  describe "GET /myrequests" do
    it "returns the list of user's requests" do
      get myrequests_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("My Requests") 
    end
  end

  describe "POST /myrequests/:id/accept" do
    it "accepts an application" do
      post myrequests_accept_path(id: application.id)
      expect(response).to redirect_to(myrequests_path)
      follow_redirect!
      expect(response.body).to include("Application accepted")
    end
  end

  describe "POST /myrequests/:id/reject" do
    it "rejects an application" do
      post myrequests_reject_path(id: application.id)
      expect(response).to redirect_to(myrequests_path)
      follow_redirect!
      expect(response.body).to include("Application rejected")
    end
  end

  describe "POST /myrequests/:id/complete" do
    it "completes a request" do
      post myrequests_complete_path(id: request_record.id)
      expect(response).to redirect_to(myrequests_path)
      follow_redirect!
      expect(response.body).to include("Congratulations! Your request is marked as complete!")
    end
  end
end
