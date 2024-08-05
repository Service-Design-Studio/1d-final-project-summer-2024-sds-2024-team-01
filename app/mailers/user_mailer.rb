class UserMailer < ApplicationMailer
  def status_update_email
    @user = params[:user]
    @message = params[:message]
    mail(to: @user.email, subject: 'Account Status Update')
  end
end
