require 'rails_helper'

RSpec.describe "MyApplicationsController", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:request) { create(:request) }
  let(:application) { create(:random_application, applicant: user, request: request) }

  before do
    sign_in user
  end

  describe "GET /myapplications" do
    it "returns the list of user's applications" do
      get myapplications_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("upcoming")
    end
  end

  describe "POST /myapplications/:id/withdraw" do
    it "withdraws an application" do
      post myapplications_withdraw_path(id: application.id)
      expect(response).to redirect_to(myapplications_path)
      follow_redirect!
      expect(response.body).to include("Withdraw success!")
    end
  end
end