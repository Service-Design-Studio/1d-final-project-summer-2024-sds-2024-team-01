class MyApplicationsController < ApplicationController
  def index
    #fetch and display a list of applications that belong to the current logged-in user
    #filtered applications are assigned to '@applications' instance variable
    @applications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id)
  end

  # Not necessary i think
  # GET /requests/1
  def show
    #fetch and display a specific application based on the id
    @application = RequestApplication.find(params[:id])
  end

end
