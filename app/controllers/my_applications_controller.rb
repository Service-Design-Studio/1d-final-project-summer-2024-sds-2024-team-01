class MyApplicationsController < ApplicationController
  def index
    # fetch and display a list of applications that belong to the current logged-in user
    # filtered applications are assigned to '@applications' instance variable
    @upcomingapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Accepted').where.not(request: { status: 'Completed' })

    @pendingapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Pending').or(RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Rejected'))

    @completedapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(request: { status: 'Completed' })

    @withdrawnapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Withdrawn')

    @applications = case params[:tab]
                    when 'withdrawn'
                      @withdrawnapplications
                    when 'completed'
                      @completedapplications
                    when 'pending'
                      @pendingapplications
                    else
                      @upcomingapplications
                    end
    puts @applications.count
    respond_to do |format|
      format.html
      format.json do
        render json: { html: render_to_string(partial: 'request_cards', locals: { requests: @applications },
                                              formats: [:html]) }
      end
    end
  end

  def withdraw
    applicationid = params[:id]
    reqtowithdraw = RequestApplication.find(applicationid)
    return unless reqtowithdraw

    reqtowithdraw.status = 'Withdrawn'
    if reqtowithdraw.save
      redirect_to '/myapplications', notice: 'Application Withdrawn'
    else
      redirect_to '/myapplications', notice: 'Error while withdrawing application'
    end
  end
end
