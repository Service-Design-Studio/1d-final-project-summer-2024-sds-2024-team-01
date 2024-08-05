class Api::V3::UserReportsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @reported_user = User.find(params[:user_id])
    @user_report = UserReport.new
  end

  def create
    Rails.logger.debug "user_report_params: #{user_report_params.inspect}"
    Rails.logger.debug "params[:user_report][:reported_user]: #{params[:user_report][:reported_user].inspect}"

    # Extract reported_user_id from params and find the corresponding User object
    reported_user_id = user_report_params[:reported_user].to_i
    Rails.logger.debug "reported_user_id: #{reported_user_id.inspect}"
    reported_user = User.find(reported_user_id)
    Rails.logger.debug "reported_user: #{reported_user.inspect}"

    # Start a transaction to ensure both operations succeed or fail together
    ActiveRecord::Base.transaction do
      # Update the reported user's status
      reported_user.update!(status: 'under_review')

      # Build the user report without the reported_user field initially
      @user_report = current_user.user_reports_as_reporter.build(user_report_params.except(:reported_user))
      
      # Assign the reported_user and reported_by fields with User objects
      @user_report.reported_user = reported_user
      @user_report.reported_by = current_user

      Rails.logger.debug "@user_report.reported_user: #{@user_report.reported_user.inspect}"

      # Save the user report
      @user_report.save!
    end

    flash[:notice] = "Report submitted successfully and user's status has been changed to under_review."
    redirect_to user_profile_path(@user_report.reported_user)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create user report or update user status: #{e.message}"
    @reported_user = User.find(reported_user_id)
    flash[:alert] = "There was an error submitting the report."
    render :new
  end

  private

  def user_report_params
    params.require(:user_report).permit(:report_reason, :reported_user)
  end
end
