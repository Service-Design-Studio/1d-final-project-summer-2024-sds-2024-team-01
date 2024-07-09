class MyRequestsController < ApplicationController
  def index
    @requests =
      Request.includes(:request_applications)
             .where(created_by: current_user.id)
             .left_outer_joins(:request_applications)
             .group('requests.id')
             .select('requests.*, COUNT(request_applications.id) as application_count')
    
    @comprequests = 
      Request.where(status: 'Completed')
  end

  # GET /requests/1
  def show
    @request = Request.find(params[:id])
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

end
