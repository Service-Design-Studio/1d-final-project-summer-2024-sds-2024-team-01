# app/mailers/request_mailer.rb
class RequestMailer < ApplicationMailer
  def request_deleted
    @user = params[:user]
    @request = params[:request]
    @reason = params[:reason]
    mail(to: @user.email, subject: 'Your request has been deleted')
  end
end
