class Cvm::CvmController < ApplicationController
  # Display dashboard
  def index
    @numemployees = User.where(status: 'Active').where(company_id: current_user.company_id).where(role_id: 4).count
    @numdeactivated = User.where.not(status: 'Active').where(company_id: current_user.company_id).where(role_id: 4).count
    @weeklyhours = User.where(status: 'Active').where(company_id: current_user.company_id).sum(:weekly_hours)

    addedids = CompanyCharity.where(company_id: current_user.company_id).pluck(:charity_id)

    @charitylist = Charity.where(id: addedids)

    @topvolunteers = User.where(status: 'Active').where(company_id: current_user.company_id).order(:weekly_hours).last(10)

    @companycode = CompanyCode.where(company_id: current_user.company_id).where(status: 'Active').last.code

    @companyname = Company.find(current_user.company_id).company_name
  end

  # /GET CVM/charities
  def manage_charities
    addedids = CompanyCharity.where(company_id: current_user.company_id).pluck(:charity_id)

    @addedcharities = Charity.where(id: addedids)
    @notaddedcharities = Charity.where.not(id: @addedcharities.pluck(:id))
  end

  # /PATCH CVM/charities/update
  def update_charities
    charity_ids = params[:charity_ids]

    charity_ids = charity_ids[0].split(',')
    charity_ids = charity_ids.map(&:to_i) # Ensure all ids are integers

    current_charity_ids = CompanyCharity.where(company_id: current_user.company_id).pluck(:charity_id)

    new_charity_ids = charity_ids - current_charity_ids

    removed_charity_ids = current_charity_ids - charity_ids

    new_charity_ids.each do |charity_id|
      CompanyCharity.create(company_id: current_user.company_id, charity_id:)
    end

    CompanyCharity.where(company_id: current_user.company_id, charity_id: removed_charity_ids).destroy_all

    redirect_to cvm_charities_path, notice: 'Charities updated successfully.'
  end

  # params = start date and end date?
  # /GET CVM/summaryreport
  def generate_report
    start_date = params[:start_date]
    end_date = params[:end_date]
    SummaryReport.create(requested_by: current_user.id)
    redirect_to "/cvm", notice: "Report generated"
  end

  def generate_new_code
    activecodes = CompanyCode.where(company_id: current_user.company_id).where(status: 'Active')
    activecodes.each do |code|
      code.status = 'Inactive'
      code.save
    end
    CompanyCode.create(company_id: current_user.company_id, status: 'Active', code: 'COMP' + rand.to_s[2..11])
    redirect_to '/cvm', notice: 'New code generated'
  end
end
