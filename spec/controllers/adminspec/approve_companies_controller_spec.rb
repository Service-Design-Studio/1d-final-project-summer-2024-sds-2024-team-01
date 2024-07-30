require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe Admin::ApproveCompaniesController, type: :controller do
  let(:admin) { create(:admin_user) }
  let(:random_company) { create(:random_company, status: 'Pending') }

  before do
    sign_in admin
    ActiveJob::Base.queue_adapter = :test
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe 'GET #index' do
    it 'assigns @companies with pending companies' do
      get :index
      expect(assigns(:companies)).to eq([random_company])
    end
  end

  describe 'GET #show' do
    it 'assigns @company' do
      get :show, params: { id: random_company.id }
      expect(assigns(:company)).to eq(random_company)
    end
  end

  describe 'POST #approve' do
    it 'approves the company and sends an email' do
      expect {
        post :approve, params: { id: random_company.id }
        perform_enqueued_jobs
      }.to change { random_company.reload.status }.from('Pending').to('Approved')

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.last.to).to include(random_company.users.find_by(role: Role.find_by(role_name: 'Admin')).email)
    end

    it 'handles approval failure' do
      allow_any_instance_of(Company).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)
      post :approve, params: { id: random_company.id }
      expect(response).to redirect_to(admin_approve_companies_path)
      expect(flash[:alert]).to eq('There was an error approving the company.')
    end
  end

  describe 'POST #reject' do
    it 'rejects the company' do
      post :reject, params: { id: random_company.id }
      expect(random_company.reload.status).to eq('Rejected')
    end
  end

  describe 'before_action #check_admin' do
    let(:non_admin) { create(:user) }

    before do
      sign_out admin
      sign_in non_admin
    end

    it 'redirects non-admin users' do
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You are not authorized to perform this action')
    end
  end
end
