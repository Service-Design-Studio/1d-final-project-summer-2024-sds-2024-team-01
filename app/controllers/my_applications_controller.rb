class MyApplicationsController < ApplicationController
  def index
    @applications = RequestApplication.includes(request: :user).where(applicant_id: current_user.id)
  end

  # GET /requests/1
  def show
    @application = RequestApplication.find(params[:id])
  end

end
