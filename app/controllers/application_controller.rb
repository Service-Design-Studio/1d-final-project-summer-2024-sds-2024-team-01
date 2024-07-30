class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # method to ensure that the right parameters are being permitted for sign up and account update.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications

  def check_role
    nil if current_user.nil
    redirect_to('/admin') if current_user.role_id == 2
    redirect_to('/corporate') if current_user.role_id == 3
    redirect_to('/charity') if current_user.role_id == 5
  end

  private

  def set_notifications
    @notifications = Notification.where(notification_for: current_user, read: false)
    @unreadcount = @notifications.count
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone email])
  end
  skip_before_action :verify_authenticity_token
end
