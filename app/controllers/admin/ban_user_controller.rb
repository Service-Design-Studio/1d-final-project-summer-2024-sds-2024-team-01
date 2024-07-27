class Admin::BanUserController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  # Render the index page
  def index
    @under_review_users = User.joins(:user_reports_as_reported_user).where(user_reports: { status: 'under_review' })
    @banned_users = User.joins(:user_reports_as_reported_user).where(user_reports: { status: 'ban' })
  end

  # Ban user function
  def ban
    user = User.find(params[:id])
    user_report = user.user_reports_as_reported_user.find_by(status: 'under_review')
    
    if user_report && user_report.update(status: 'ban')
      user.update(status: 'banned') 
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  # Unban user function
  def unban
    user = User.find(params[:id])
    user_report = user.user_reports_as_reported_user.find_by(status: 'ban')
    
    if user_report && user_report.update(status: 'under_review')
      user.update(status: 'normal')
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  # Cancel ban function
  def cancel_ban
    user = User.find(params[:id])
    user_report = user.user_reports_as_reported_user.find_by(status: 'under_review')
    
    if user_report && user_report.update(status: 'under_review')
      user.update(status: 'normal') 
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  private

  def authorize_admin!
    redirect_to(root_path, alert: 'You are not authorized to access this page.') unless current_user&.admin?
  end
end
  