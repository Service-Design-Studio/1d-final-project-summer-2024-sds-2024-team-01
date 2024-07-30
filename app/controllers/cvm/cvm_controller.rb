class Cvm::CvmController < ApplicationController

  # Display dashboard
  def index
    @numemployees = User.where(company_id: current_user.company_id).count
    @weeklyhours = 23
    @charitylist = CompanyCharity.where(company_id: current_user.company_id)
    @topvolunteers = User.where(name: "Alice Smith")
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
end
