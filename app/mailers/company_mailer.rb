class CompanyMailer < ApplicationMailer
    default from: 'no-reply@example.com'  # Replace with your desired default sender email
  
    def approval_email
      @company = params[:company]
      @code = params[:code]
      mail(to: @company.users.find_by(role_id: 3).email, subject: 'Your Company has been Approved')
    end
  end
  