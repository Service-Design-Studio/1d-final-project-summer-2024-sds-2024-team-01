module Admin
  class BanUserController < ApplicationController
    before_action :authenticate_user!, :require_admin

    def index
      @user_reports = UserReport.all
      @reported_users = User.where(reported: true)
      @banned_users = User.where(banned: true)
    end

    def ban
      user = User.find(params[:id])
      user.update(banned: true, ban_reason: params[:ban_reason])
      redirect_to admin_ban_user_index_path, notice: "#{user.name} has been banned."
    end

    def unban
      user = User.find(params[:id])
      user.update(banned: false, ban_reason: nil)
      redirect_to admin_ban_user_index_path, notice: "#{user.name} has been unbanned."
    end

    private

    def require_admin
      redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
    end
  end

  class UserReportsController < ApplicationController
    before_action :authenticate_user!, :require_admin

    def index
      @user_reports = UserReport.all
    end

    def new
      @user_report = UserReport.new
    end

    def create
      @user_report = UserReport.new(user_report_params)
      if @user_report.save
        redirect_to admin_user_reports_path, notice: 'Report successfully created.'
      else
        render :new
      end
    end

    private

    def user_report_params
      params.require(:user_report).permit(:report_reason, :status, :reported_by, :reported_user)
    end

    def require_admin
      redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
    end
  end
end
