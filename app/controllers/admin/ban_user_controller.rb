class Admin::BanUserController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @reported_users = User.joins(:user_reports).where(user_reports: { status: 'under_review' })
    @banned_users = User.joins(:user_reports).where(user_reports: { status: 'ban' })
  end

  def ban
    user = User.find(params[:id])
    user.user_reports.where(status: 'under_review').update_all(status: 'ban')
    redirect_to admin_ban_user_index_path, notice: 'User has been banned.'
  end

  def unban
    user = User.find(params[:id])
    user.user_reports.where(status: 'ban').update_all(status: 'unban')
    redirect_to admin_ban_user_index_path, notice: 'User has been unbanned.'
  end

  private

  def authorize_admin!
    redirect_to(root_path, alert: 'You are not authorized to access this page.') unless current_user&.admin?
  end
end
