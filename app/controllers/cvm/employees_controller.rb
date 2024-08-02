class Cvm::EmployeesController < ApplicationController
  # Display all employees
  def index
    @allemployees = User.where(company_id: current_user.company_id).where(role_id: 4).order(:total_hours)
  end

  # /PATCH cvm/employees/deactivate
  def deactivate
    user = User.find(params[:employee_id])
    user.status = 'Inactive'
    if user.save
      redirect_to '/cvm/employees', notice: "Account for #{user.name} has been deactivated"
    else
      redirect_to '/cvm/employees', notice: 'Failed to deactivate account'
    end
  end

  # /POST cvm/employees/activate
  def activate
    user = User.find(params[:employee_id])
    user.status = 'Active'
    if user.save
      redirect_to '/cvm/employees', notice: "Account for #{user.name} has been activated"
    else
      redirect_to '/cvm/employees', notice: 'Failed to activate account'
    end
  end
end
