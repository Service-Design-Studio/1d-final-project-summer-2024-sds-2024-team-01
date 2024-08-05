class Admin::ApproveCompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_company, only: [:show, :approve, :disable, :reject]

  def index
    @active_companies = Company.where(status: 'Active')
    @inactive_companies = Company.where(status: 'Inactive')
    @rejected_companies = Company.where(status: 'Rejected')
  end

  def show
    @company = Company.find(params[:id])
  end

  def approve
    Company.transaction do
      @company.update!(status: 'Active')
      unique_code = generate_unique_code
      CompanyCode.create!(company: @company, status: 'Approved', code: unique_code)
      CompanyMailer.with(company: @company, code: unique_code).approval_email.deliver_later
    end
    redirect_to admin_approve_companies_path, notice: 'Company has been approved and email sent.'
  rescue ActiveRecord::RecordInvalid
    redirect_to admin_approve_companies_path, alert: 'There was an error approving the company.'
  end

  def disable
    @company.update(status: 'Inactive')
    redirect_to admin_approve_companies_path, notice: 'Company has been disabled.'
  end

  def reject
    @company.update(status: 'Rejected')
    redirect_to admin_approve_companies_path, notice: 'Company has been rejected.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def check_admin
    redirect_to root_path, alert: 'You are not authorized to perform this action' unless current_user.admin?
  end

  def generate_unique_code
    SecureRandom.hex(10)
  end
end
