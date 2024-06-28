class MyRequestsController < ApplicationController
  # GET /myrequests
  def index
    # This would show all requests made by the user 
    @requests = Request.all
  end

  def applications
    # This would show the applications by other users for this specific request

  end

  def edit
    # Edit the request
  end
  def delete
    # Delete the request
  end
end
