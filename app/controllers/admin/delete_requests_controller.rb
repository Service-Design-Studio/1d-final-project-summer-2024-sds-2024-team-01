# class Admin::DeleteRequestsController < ApplicationController
#   before_action :authenticate_user!
#   before_action :admin_only
#   before_action :set_request, only: [:destroy, :confirm]

#   # GET /admin/delete_requests
#   def index
#     @requests = Request.all
#   end

#   # GET /admin/delete_requests/:id/confirm
#   def confirm
#     # This action will render the delete confirmation page
#   end

#   # DELETE /admin/delete_requests/:id
#   def destroy
#     reason = params[:reason]
#     if @request.destroy
#       # Notify the requester
#       RequestMailer.with(user: @request.user, request: @request, reason: reason).request_deleted.deliver_now
#       # # Send notification
#       # Notification.create(
#       #   user_id: @request.user.id,
#       #   message: "Your request titled '#{@request.title}' was deleted by an admin for the following reason: #{reason}"
#       # )
#       redirect_to requests_path, notice: 'Request was successfully deleted.'
#     else
#       redirect_to admin_delete_requests_url, alert: 'Failed to delete the request.'
#     end
#   end

#   private

#   def set_request
#     @request = Request.find(params[:id])
#   end

#   def admin_only
#     redirect_to(root_path) unless current_user.admin?
#   end
# end
