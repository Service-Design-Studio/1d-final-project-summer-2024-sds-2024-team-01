class CharityMailer < ApplicationMailer
  default from: 'no-reply@example.com'  # Replace with your desired default sender email

  def approval_email
    @charity = params[:charity]
    @code = params[:code]
    charity_manager = @charity.users.find_by(role_id: 5)
    if charity_manager
      Rails.logger.debug "Sending approval email to: #{charity_manager.email}"
      mail(to: charity_manager.email, subject: 'Your Charity has been Approved')
    else
      Rails.logger.debug "No charity manager found for charity: #{@charity.id}"
    end
  end
end
