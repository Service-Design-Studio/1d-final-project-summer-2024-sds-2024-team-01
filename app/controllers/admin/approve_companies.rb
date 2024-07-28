module Admin
  class CompaniesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :set_company, only: [:show, :approve, :reject]

    def index
      @companies = Company.where(status: 'Pending')
    end

    def show
    end

    def approve
      Company.transaction do
        @company.update!(status: 'Approved')
        unique_code = generate_unique_code
        CompanyCode.create!(company: @company, status: 'Approved', code: unique_code)
        CompanyMailer.with(company: @company, code: unique_code).approval_email.deliver_later
      end
      redirect_to admin_companies_path, notice: 'Company has been approved and email sent.'
    rescue ActiveRecord::RecordInvalid
      redirect_to admin_companies_path, alert: 'There was an error approving the company.'
    end

    def reject
      @company.update(status: 'Rejected')
      # Optionally, you could also delete the company record here if needed
      redirect_to admin_companies_path, notice: 'Company has been rejected and email sent.'
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
end
