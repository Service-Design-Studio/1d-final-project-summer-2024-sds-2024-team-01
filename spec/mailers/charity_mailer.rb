class CharityMailer < ApplicationMailer
    default from: 'no-reply@example.com'
  
    def approval_email
      @charity = params[:charity]
      @code = params[:code]
      mail(to: @charity.users.first.email, subject: 'Your Charity has been Approved') if @charity.users.any?
    end
  end
  