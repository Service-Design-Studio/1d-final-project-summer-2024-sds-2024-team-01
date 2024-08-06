require 'rails_helper'

RSpec.describe Admin::ApproveCompaniesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:company) { create(:random_company, status: 'Active') }
  let(:inactive_company) { create(:random_company, status: 'Inactive') }
  let(:company_code) { create(:random_company_code, company: company) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'assigns the active companies' do
      company
      get :index
      expect(assigns(:active_companies)).to eq([company])
    end

    it 'assigns the inactive companies' do
      inactive_company
      get :index
      expect(assigns(:inactive_companies)).to eq([inactive_company])
    end

    it 'assigns the rejected companies' do
      rejected_company = create(:random_company, status: 'Rejected')
      get :index
      expect(assigns(:rejected_companies)).to eq([rejected_company])
    end
  end

  describe 'PATCH #approve' do
    it 'approves the company and sends an approval email' do
      patch :approve, params: { id: inactive_company.id }
      inactive_company.reload
      expect(inactive_company.status).to eq('Active')
      expect(inactive_company.users.first.status).to eq('Active')
      expect(CompanyCode.last.status).to eq('Active')
      expect(response).to redirect_to(admin_approve_companies_path)
    end
  end

  describe 'PATCH #disable' do
    it 'disables the company and its associated codes' do
      company_code
      patch :disable, params: { id: company.id }
      company.reload
      company_code.reload
      expect(company.status).to eq('Inactive')
      expect(company.users.first.status).to eq('Inactive')
      expect(company_code.status).to eq('Inactive')
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

  describe 'GET #show' do
    it 'assigns the requested company as @company' do
      get :show, params: { id: company.id }
      expect(assigns(:company)).to eq(company)
    end
  end
end
