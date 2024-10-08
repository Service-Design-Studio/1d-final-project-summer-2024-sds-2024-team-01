class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # method to ensure that the right parameters are being permitted for sign up and account update.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications
  before_action :check_role

  def check_role
    return if current_user.nil?
    allowed_routes = ['/login', '/logout', '/profile']
    apply_routes = ['/requests/apply', '/myapplications', '/myapplications/withdraw']
    create_req_routes = ['/requests/new', '/myrequests']

    case current_user.role_id
    when 3
      return if allowed_routes.any? { |route| request.path.start_with?(route) } || request.path.start_with?('/cvm')

      redirect_to '/cvm'
    when 2
      return if allowed_routes.any? { |route| request.path.start_with?(route) } || request.path.start_with?('/admin')

      redirect_to '/admin'
    when 5
      return if allowed_routes.any? { |route| request.path.start_with?(route) } || !apply_routes.any? { |route| request.path.start_with?(route) }

    when 4
      return if allowed_routes.any? { |route| request.path.start_with?(route) } || !create_req_routes.any? { |route| request.path.start_with?(route) }
      redirect_to '/'
    end

  end

  private

  def set_notifications
    @notifications = Notification.where(notification_for: current_user, read: false)
    @unreadcount = @notifications.count
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone email])
  end

  skip_before_action :verify_authenticity_token
end
