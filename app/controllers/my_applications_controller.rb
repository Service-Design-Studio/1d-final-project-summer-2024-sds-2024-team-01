class MyApplicationsController < ApplicationController
  def index
    # fetch and display a list of applications that belong to the current logged-in user
    # filtered applications are assigned to '@applications' instance variable
    @pendingapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where(status: 'Pending')
    @nonpendingapplications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id).where.not(status: 'Pending')
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
