class Cvm::CvmController < ApplicationController

  # Display dashboard
  def index
    @numemployees = User.where(company_id: current_user.company_id).count
    @weeklyhours = User.where(company_id: current_user.company_id).sum(:weekly_hours)
    @charitylist = CompanyCharity.where(company_id: current_user.company_id)
    @topvolunteers = User.where(company_id: current_user.company_id).order(:weekly_hours).last(3)
    @companycode = CompanyCode.where(company_id: current_user.company_id).where(status: 'Active').last
  end

  # /GET CVM/charities
  def manage_charities
  end

  # /POST CVM/charities/update
  def update_charities
  end

  # params = start date and end date?
  # /GET CVM/summaryreport
  def generate_report
  end

  def generate_new_code
  end
end
