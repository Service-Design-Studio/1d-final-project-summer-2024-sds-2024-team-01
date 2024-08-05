require 'rails_helper'

RSpec.describe Admin::ApproveCompaniesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:company) { create(:company) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: company.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #approve' do
    it 'approves the company' do
      patch :approve, params: { id: company.id }
      company.reload
      expect(company.status).to eq('Active')
      expect(response).to redirect_to(admin_approve_companies_path)
    end
  end

  describe 'PATCH #disable' do
    it 'disables the company' do
      patch :disable, params: { id: company.id }
      company.reload
      expect(company.status).to eq('Inactive')
      expect(response).to redirect_to(admin_approve_companies_path)
    end
  end

  describe 'PATCH #reject' do
    it 'rejects the company' do
      patch :reject, params: { id: company.id }
      company.reload
      expect(company.status).to eq('Rejected')
      expect(response).to redirect_to(admin_approve_companies_path)
    end
  end
end
