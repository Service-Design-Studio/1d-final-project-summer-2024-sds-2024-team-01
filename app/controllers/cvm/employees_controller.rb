class Cvm::EmployeesController < ApplicationController
  # Display all employees
  def index
    start_of_week = Time.zone.now.beginning_of_week
    end_of_week = Time.zone.now.end_of_week

    @allemployees = User.where(company_id: current_user.company_id).where(role_id: 4).order(:status, total_hours: :desc, name: :asc)
    @allemployees.each do |employee|
        employee.weekly_hours = RequestApplication.joins(:request).where(
        updated_at: start_of_week..end_of_week,
        applicant_id: employee.id,
        status: 'Completed'
      ).sum('requests.duration')
    end
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
