class MyRequestsController < ApplicationController
  def index
    @requests =
      Request.includes(:request_applications)
             .where(created_by: current_user.id)
             .left_outer_joins(:request_applications)
             .group('requests.id')
             .select('requests.*,
             COUNT(request_applications.id) as application_count,
             array_agg(request_applications.applicant_id) as applicant_ids')

    # Fetch all unique applicant IDs
    all_applicant_ids = @requests.map(&:applicant_ids).flatten.uniq.compact

    # Fetch all applicants in one query
    @applicants = User.where(id: all_applicant_ids).index_by(&:id)
  end

  # GET /requests/1
  def show
    @request = Request.find(params[:id])
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  def accept
    @reqapp = RequestApplication.find(params[:id])
    return if current_user.id != Request.find(@reqapp.request_id).created_by
    @reqapp.status = "Accepted"
    @reqapp.save
    redirect_to '/myrequests', notice: 'Application accepted'
  end

  def reject
    @reqapp = RequestApplication.find(params[:id])
    return if current_user.id != Request.find(@reqapp.request_id).created_by
    @reqapp.status = "Rejected"
    @reqapp.save
    redirect_to '/myrequests', notice: 'Application rejected'
  end
end
