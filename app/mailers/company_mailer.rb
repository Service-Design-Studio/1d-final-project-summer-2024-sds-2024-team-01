class CompanyMailer < ApplicationMailer
  def approval_email
    @company = params[:company]
    @code = params[:code]
    mail(to: @company.users.find_by(role_id: 3).email, subject: 'Your Company Has Been Approved')
  end
end
