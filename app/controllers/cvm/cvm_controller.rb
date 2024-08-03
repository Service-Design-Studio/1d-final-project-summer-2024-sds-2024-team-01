class Cvm::CvmController < ApplicationController
  require 'csv'
  # Display dashboard
  def index
    @numemployees = User.where(status: 'Active').where(company_id: current_user.company_id).where(role_id: 4).count
    @numdeactivated = User.where.not(status: 'Active').where(company_id: current_user.company_id).where(role_id: 4).count
    @weeklyhours = User.where(status: 'Active').where(company_id: current_user.company_id).sum(:weekly_hours)

    addedids = CompanyCharity.where(company_id: current_user.company_id).pluck(:charity_id)

    @charitylist = Charity.where(id: addedids)

    @topvolunteers = User.where(status: 'Active').where(company_id: current_user.company_id).order(weekly_hours: :desc).first(10)

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

    if start_date.nil? || end_date.nil?
      redirect_to '/cvm', notice: "Please enter a date range for the report"
      return
    end

    company_id = current_user.company_id

    employees = User.where(company_id:)
    employee_ids = User.where(company_id:).pluck(:id)

    incomplete_in_date_range = RequestApplication.where(updated_at: start_date..end_date).where.not(status: 'Completed').where(applicant_id: employee_ids)
    completed_in_date_range = RequestApplication.where(updated_at: start_date..end_date).where(status: 'Completed').where(applicant_id: employee_ids)

    total_hours_all_employees = Request.where(id: completed_in_date_range.pluck(:request_id)).sum(:duration)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Date range start date', start_date]
      csv << ['Date range end date', end_date]
      csv << ['']
      csv << ['Total hours in time range: ', total_hours_all_employees]
      csv << ['Total completed requests in time range: ', completed_in_date_range.count]
      csv << ['Total incomplete requests in time range: ', incomplete_in_date_range.count]
      csv << ['']
      csv << ['']

      csv << ['Employee Name', 'Email', 'Total Hours', 'Requests Not Completed', 'Requests Completed']

      employees.each do |employee|
        incomplete = incomplete_in_date_range.where(applicant_id: employee.id)
        complete = completed_in_date_range.where(applicant_id: employee.id)

        hours_in_time_range = Request.where(id: complete.pluck(:request_id)).sum(:duration)
        csv << [
          employee.name,
          employee.email,
          hours_in_time_range,
          incomplete.count,
          complete.count
        ]

        csv << ['']
        csv << ['Completed Requests']
        complete.each do |application|
          request = Request.find(application.request_id)

          csv << ['Request Id', 'Request Title', 'Request Duration', 'Request Date', 'Request Time', 'Request Location',
                  'Requested By']

          csv << [
            request.id,
            request.title,
            request.duration,
            request.date,
            request.start_time.strftime('%H:%M:%S'),
            request.stringlocation,
            User.find(request.created_by).name
          ]
        end
        csv << ['']

        csv << ['Incomplete Requests']
        incomplete.each do |application|
          request = Request.find(application.request_id)

          csv << ['Request Id', 'Request Title', 'Request Duration', 'Request Date', 'Request Time', 'Request Location',
                  'Requested By']

          csv << [
            request.id,
            request.title,
            request.duration,
            request.date,
            request.start_time.strftime('%H:%M:%S'),
            request.stringlocation,
            User.find(request.created_by).name
          ]
        end
        csv << ['']
      end
    end
    send_data csv_data, filename: "employees_data_#{Date.today}.csv"

    SummaryReport.create(requested_by: current_user.id)

    # redirect_to '/cvm', notice: 'Report generated'
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
