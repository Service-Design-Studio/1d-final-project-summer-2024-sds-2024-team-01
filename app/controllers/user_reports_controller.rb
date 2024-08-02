class UserReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @reported_user = User.find(params[:user_id])
    @user_report = UserReport.new
  end

  def create
    Rails.logger.debug "user_report_params: #{user_report_params.inspect}"
    Rails.logger.debug "params[:user_report][:reported_user]: #{params[:user_report][:reported_user].inspect}"

    # Build the user report without the reported_user field initially
    @user_report = current_user.user_reports_as_reporter.build(user_report_params.except(:reported_user))
    
    # Convert reported_user to a User object and assign it
    reported_user_id = params[:user_report][:reported_user].to_i
    @user_report.reported_user = User.find(reported_user_id)
    @user_report.reported_by = current_user

    Rails.logger.debug "@user_report.reported_user: #{@user_report.reported_user.inspect}"

    if @user_report.save
      flash[:notice] = "Report submitted successfully."
      redirect_to user_profile_path(@user_report.reported_user)
    else
      @reported_user = User.find(reported_user_id)
      render :new
    end
  end

  private

  def user_report_params
    params.require(:user_report).permit(:report_reason, :reported_user)
  end
end
Í