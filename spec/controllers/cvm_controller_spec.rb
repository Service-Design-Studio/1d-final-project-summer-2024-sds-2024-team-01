require 'rails_helper'

RSpec.describe Cvm::CvmController, type: :controller do
  let!(:company) { create(:random_company) }
  let!(:charity) { create(:random_charity) }
  let!(:company_code) { create(:random_company_code, company: company, status: 'Active') }
  let!(:cvm) { create(:user, role_id: 3, company_id: company.id) }
  let!(:user) { create(:user, role_id: 4, company_id: company.id) }
  let!(:charuser) { create(:user, role_id: 5, charity_id: charity.id) }
  let!(:company_charity) { create(:random_company_charity, company: company, charity: charity) }
  
  before do
    sign_in cvm
  end

  describe 'GET #index' do
    it 'assigns the correct instance variables' do
      get :index
      expect(assigns(:numemployees)).to eq(1)
      expect(assigns(:numdeactivated)).to eq(0)
      expect(assigns(:weeklyhours)).to eq(user.weekly_hours)
      expect(assigns(:charitylist)).to include(charity)
      expect(assigns(:topvolunteers)).to include(user)
      expect(assigns(:companycode)).to eq(company_code.code)
      expect(assigns(:companyname)).to eq(company.company_name)
    end
  end

  describe 'GET #manage_charities' do
    it 'assigns the correct instance variables' do
      get :manage_charities
      expect(assigns(:addedcharities)).to include(charity)
      expect(assigns(:notaddedcharities)).not_to include(charity)
    end
  end

  describe 'PATCH #update_charities' do
    let(:new_charity) { create(:random_charity) }

    it 'updates the charities correctly' do
      patch :update_charities, params: { charity_ids: "#{new_charity.id}" }
      expect(CompanyCharity.find_by(company: company, charity: new_charity)).not_to be_nil
      expect(CompanyCharity.find_by(company: company, charity: charity)).to be_nil
      expect(response).to redirect_to(cvm_charities_path)
      expect(flash[:notice]).to eq('Charities updated successfully.')
    end
  end

  describe 'GET #generate_report' do
    let(:start_date) { 1.week.ago }
    let(:end_date) { Date.today }
    let!(:completed_request) { create(:request, status: 'Completed', created_by: charuser.id) }
    let!(:incomplete_request) { create(:request, status: 'Incomplete', created_by: charuser.id) }
    let!(:completed_request_application) { create(:application, request: completed_request, applicant: user, status: 'Completed') }
    let!(:incomplete_request_application) { create(:application, request: incomplete_request, applicant: user, status: 'Incomplete') }

    it 'generates the CSV report' do
      get :generate_report, params: { start_date: start_date, end_date: end_date }
      expect(response.header['Content-Disposition']).to include("attachment; filename=\"employees_data_#{Date.today}.csv\"")
    end

    it 'redirects if date range is not provided' do
      get :generate_report
      expect(response).to redirect_to('/cvm')
      expect(flash[:notice]).to eq("Please enter a date range for the report")
    end
  end

  describe 'POST #generate_new_code' do
    it 'generates a new code and deactivates old codes' do
      post :generate_new_code
      expect(company_code.reload.status).to eq('Inactive')
      new_code = CompanyCode.find_by(company: company, status: 'Active')
      expect(new_code).not_to be_nil
      expect(new_code.code).to start_with('COMP')
      expect(response).to redirect_to('/cvm')
      expect(flash[:notice]).to eq('New code generated')
    end
  end
end

