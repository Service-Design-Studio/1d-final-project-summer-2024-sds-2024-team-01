class Admin::BanUserController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @under_review_users = User.joins(:user_reports_as_reported_user).where(user_reports: { status: 'under_review' }).distinct
    @banned_users = User.joins(:user_reports_as_reported_user).where(user_reports: { status: 'ban' }).distinct
  end

  def ban
    user = User.find(params[:id])
    user_reports = user.user_reports_as_reported_user.where(status: 'under_review')

    if user_reports.exists?
      user_reports.update_all(status: 'ban')
      render json: { success: true, message: "Successfully banned." }
    else
      render json: { success: false, message: "Ban failed." }
    end
  end

  def unban
    user = User.find(params[:id])
    user_reports = user.user_reports_as_reported_user.where(status: 'ban')

    if user_reports.exists?
      user_reports.update_all(status: 'Active')
      render json: { success: true, message: "Successfully unbanned." }
    else
      render json: { success: false, message: "Unban failed." }
    end
  end

  def cancel_ban
    user = User.find(params[:id])
    user_reports = user.user_reports_as_reported_user.where(status: 'under_review')

    if user_reports.exists?
      user_reports.update_all(status: 'Active')
      render json: { success: true, message: "Successfully cancelled." }
    else
      render json: { success: false, message: "Cancel ban failed." }
    end
  end

  private

  def authorize_admin!
    redirect_to(root_path, alert: 'You are not authorized to access this page.') unless current_user&.admin?
  end
end
