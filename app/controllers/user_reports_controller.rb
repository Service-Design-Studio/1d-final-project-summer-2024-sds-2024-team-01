class UserReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(params[:reported_user])
    @report = UserReport.new
  end

  def create
    Rails.logger.debug "Parameters in create: #{params.inspect}"
    @user = User.find(params[:user_report][:reported_user])
    @report = UserReport.new(report_params)
    @report.reported_by = current_user
    @report.reported_user = @user
    if @report.save
      @user.update(status: 'under_review') if @user.status == 'Active'
      redirect_to requests_path, notice: 'User has been reported successfully.'
    else
      render :new
    end
  end

  def confirm
    Rails.logger.debug "Parameters in confirm: #{params.inspect}"
    @user = User.find(params[:user_report][:reported_user])
    @report_reason = params[:user_report][:report_reason]
  end

  private

  def report_params
    params.require(:user_report).permit(:report_reason)
  end
end
