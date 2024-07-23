module Admin
  class BanUserController < ApplicationController
    before_action :authenticate_user!, :require_admin

    def index
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
end
