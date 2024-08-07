require 'rails_helper'

RSpec.describe "Admin::ApproveCompaniesController", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:admin) { create(:user, :admin) }
  let!(:company) { create(:random_company) }

  before do
    sign_in admin
  end

  describe "GET /admin/approve_companies" do
    it "lists all companies" do
      get admin_approve_companies_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Active Companies")
    end
  end

  describe "GET /admin/approve_companies/:id" do
    it "shows a specific company" do
      get admin_approve_company_path(company)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(company.company_name)
    end
  end

  describe "PATCH /admin/approve_companies/:id/approve" do
    it "approves a company" do
      patch approve_admin_approve_company_path(company)
      expect(response).to redirect_to(admin_approve_companies_path)
      follow_redirect!
      expect(response.body).to include("Company has been approved and email sent.")
    end
  end

  describe "PATCH /admin/approve_companies/:id/disable" do
    it "disables a company" do
      patch disable_admin_approve_company_path(company)
      expect(response).to redirect_to(admin_approve_companies_path)
      follow_redirect!
      expect(response.body).to include("Company has been disabled.")
    end
  end

  describe "PATCH /admin/approve_companies/:id/reject" do
    it "rejects a company" do
      patch reject_admin_approve_company_path(company)
      expect(response).to redirect_to(admin_approve_companies_path)
      follow_redirect!
      expect(response.body).to include("Company has been rejected.")
    end
  end
end