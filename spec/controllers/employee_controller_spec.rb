require 'rails_helper'

RSpec.describe Cvm::EmployeesController, type: :controller do
  let!(:company) { create(:random_company) }
  let!(:cvm) { create(:user, role_id: 3, company_id: company.id) }
  let!(:employee) { create(:user, role_id: 4, company_id: company.id, status: 'Active') }

  before do
    sign_in cvm
  end

  describe 'GET #index' do
    it 'assigns @allemployees' do
      get :index
      expect(assigns(:allemployees)).to eq([employee])
    end

    it 'calculates weekly_hours for each employee' do
      create(:application, applicant: employee, status: 'Completed', request: create(:request, duration: 5, status: 'Completed'))
      get :index
      expect(assigns(:allemployees).first.weekly_hours).to eq(5)
    end

    it 'orders employees by status, total_hours, and name' do
      employee2 = create(:user, role_id: 4, company_id: company.id, status: 'Active', total_hours: 10, name: 'B')
      employee3 = create(:user, role_id: 4, company_id: company.id, status: 'Active', total_hours: 20, name: 'A')
      get :index
      expect(assigns(:allemployees).to_a).to eq([employee3, employee2, employee])
    end
  end

  describe 'PATCH #deactivate' do
    it 'deactivates the employee and redirects to index with a success notice' do
      patch :deactivate, params: { employee_id: employee.id }
      employee.reload
      expect(employee.status).to eq('Inactive')
      expect(response).to redirect_to('/cvm/employees')
      expect(flash[:notice]).to eq("Account for #{employee.name} has been deactivated")
    end

    it 'redirects to index with a failure notice if deactivation fails' do
      allow_any_instance_of(User).to receive(:save).and_return(false)
      patch :deactivate, params: { employee_id: employee.id }
      expect(response).to redirect_to('/cvm/employees')
      expect(flash[:notice]).to eq('Failed to deactivate account')
    end
  end

  describe 'POST #activate' do
    before { employee.update(status: 'Inactive') }

    it 'activates the employee and redirects to index with a success notice' do
      post :activate, params: { employee_id: employee.id }
      employee.reload
      expect(employee.status).to eq('Active')
      expect(response).to redirect_to('/cvm/employees')
      expect(flash[:notice]).to eq("Account for #{employee.name} has been activated")
    end

    it 'redirects to index with a failure notice if activation fails' do
      allow_any_instance_of(User).to receive(:save).and_return(false)
      post :activate, params: { employee_id: employee.id }
      expect(response).to redirect_to('/cvm/employees')
      expect(flash[:notice]).to eq('Failed to activate account')
    end
  end
end

