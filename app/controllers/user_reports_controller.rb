class UserReportsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @reported_user = User.find(params[:user_id])
      @user_report = UserReport.new
    end
  
    def create
      @user_report = current_user.user_reports_as_reporter.build(user_report_params)
      @user_report.reported_user = User.find(params[:user_report][:reported_user_id])
      @user_report.reported_by = current_user
  
      if @user_report.save
        flash[:notice] = "Report submitted successfully."
        redirect_to user_profile_path(@user_report.reported_user)
      else
        @reported_user = User.find(params[:user_report][:reported_user_id])
        render :new
      end
    end
  
    private
  
    def user_report_params
      params.require(:user_report).permit(:report_reason)
    end
  end
  