class MyApplicationsController < ApplicationController
  def index
    @current_tab = params[:tab] || 'upcoming'
    
    @upcomingapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Accepted').where.not(request: { status: 'Completed' })
    @pendingapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Pending')
    @completedapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Accepted').where(request: { status: 'Completed' }).or(RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Completed'))
    @withdrawnapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Withdrawn').or(RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Rejected'))
  
    @applications = instance_variable_get("@#{@current_tab}applications")


    respond_to do |format|
      format.html
      format.json do
        render json: {
          html: render_to_string(partial: @applications.empty? ? 'shared/empty_state' : 'request_cards', locals: { requests: @applications }, formats: [:html]),
          is_empty: @applications.empty?
        }
      end
    end
  end

  def withdraw
    applicationid = params[:id]
    reqtowithdraw = RequestApplication.find(applicationid)
    return unless reqtowithdraw

    reqtowithdraw.status = 'Withdrawn'
    if reqtowithdraw.save
      create_withdrawal_notification(reqtowithdraw)
      respond_to do |format|
        format.html { redirect_to '/myapplications', flash: { warning: "Withdraw success! Do consider your schedule carefully before applying in the future." } }
        # format.js {
        #   render js: "document.dispatchEvent(new CustomEvent('application:withdrawn', 
        #     { detail: { requestId: #{reqtowithdraw.request_id}, applicationId: #{reqtowithdraw.id} } }));"
        # }
      end
    else
      redirect_to '/myapplications', flash: { error: "An error occurred with the withdrawing. Please try again later." }
    end
  end

  private

  # def update_request_count(request)
  #   new_count = request.request_applications.where.not(status: 'Withdrawn').count
  #   request.update(application_count: new_count)
  # end

  def create_withdrawal_notification(application)
    Notification.create(
      notification_for: application.request.user,
      message: "#{application.applicant.name} has withdrawn their application for your request '#{application.request.title}'.",
      url: "/myrequests",
      header: 'Application Withdrawn',
      read: false
    )
  end
end
