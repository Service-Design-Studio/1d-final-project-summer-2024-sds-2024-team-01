class Admin::BanUserController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @under_review_users = User.joins(:user_reports_as_reported_user).where(user_reports: { status: UserReport.statuses[:under_review] }).distinct
    @banned_users = User.joins(:user_reports_as_reported_user).where(user_reports: { status: UserReport.statuses[:banned] }).distinct
  end

  def ban
    user = User.find(params[:id])
    user_report = user.user_reports_as_reported_user.find_by(status: UserReport.statuses[:under_review])
    if user_report && user_report.update(status: :banned)
      user.update(status: :banned)
      Notification.create(user: user, message: 'Your account has been banned.')
      render json: { success: true, message: 'User has been banned.' }
    else
      render json: { success: false, message: 'Failed to ban user.' }
    end
  end

  def unban
    user = User.find(params[:id])
    user_report = user.user_reports_as_reported_user.find_by(status: :banned)
    if user_report && user_report.update(status: :normal)
      user.update(status: :normal)
      Notification.create(user: user, message: 'Your account has been unbanned. Welcome back!')
      render json: { success: true, message: 'User has been unbanned.' }
    else
      render json: { success: false, message: 'Failed to unban user.' }
    end
  end

  def cancel_ban
    user = User.find(params[:id])
    user_report = user.user_reports_as_reported_user.find_by(status: UserReport.statuses[:under_review])
    if user_report && user_report.update(status: :normal)
      user.update(status: :normal)
      render json: { success: true, message: 'Ban has been cancelled.' }
    else
      render json: { success: false, message: 'Failed to cancel ban.' }
    end
  end

  private

  def authorize_admin!
    redirect_to(root_path, alert: 'You are not authorized to access this page.') unless current_user&.admin?
  end
end
