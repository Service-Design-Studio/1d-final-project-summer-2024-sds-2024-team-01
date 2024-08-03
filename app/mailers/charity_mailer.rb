class CharityMailer < ApplicationMailer
    default from: 'no-reply@example.com'  # Replace with your desired default sender email
  
    def approval_email
      @charity = params[:charity]
      @code = params[:code]
      mail(to: @charity.users.first.email, subject: 'Your Charity has been Approved')
    end
  end
  