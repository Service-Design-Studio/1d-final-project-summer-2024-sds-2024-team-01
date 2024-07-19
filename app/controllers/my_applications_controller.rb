class MyApplicationsController < ApplicationController
  def index
    #fetch and display a list of applications that belong to the current logged-in user
    #filtered applications are assigned to '@applications' instance variable
    @applications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id)
  end

  def withdraw
    applicationid = params[:id]
    reqtowithdraw = RequestApplication.find(applicationid)
    if reqtowithdraw then
      reqtowithdraw.status = "Withdrawn"
    end
  end

end
