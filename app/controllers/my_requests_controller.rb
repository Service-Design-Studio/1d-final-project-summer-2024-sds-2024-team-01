class MyRequestsController < ApplicationController
  def index
    @requests = Request.includes(:request_applications)
                       .where(created_by: current_user.id)
                       .left_outer_joins(:request_applications)
                       .group('requests.id')
                       .select('requests.*,
                                COUNT(request_applications.id) as application_count,
                                COUNT(CASE WHEN request_applications.status = \'Accepted\' THEN 1 END) as accepted_application_count,
                                array_agg(request_applications.applicant_id) as applicant_ids')

    today_start = Date.today.beginning_of_day
    @in_progress_requests = @requests.where("date > ?", today_start)
                                     .where.not(status: 'Completed')
    @completed_requests = @requests.where(status: 'Completed')
    @unfulfilled_requests = @requests.where("date <= ?", today_start)
                                     .where.not(status: 'Completed')

    @requests = case params[:tab]
                when 'completed'
                  @completed_requests
                when 'unfulfilled'
                  @unfulfilled_requests
                else
                  @in_progress_requests
                end

    # Fetch all unique applicant IDs
    all_applicant_ids = @requests.map(&:applicant_ids).flatten.uniq.compact

    # Fetch all applicants in one query
    @applicants = User.where(id: all_applicant_ids).index_by(&:id)

    respond_to do |format|
      format.html
      format.json do
        @requests = case params[:tab]
                    when 'completed'
                      @completed_requests
                    when 'unfulfilled'
                      @unfulfilled_requests
                    else
                      @in_progress_requests
                    end
        render json: { 
          html: render_to_string(partial: 'request_cards', locals: { requests: @requests }, formats: [:html])
        }
      end
    end
  end

  # Redirect directly to let requestcontroller handle
  # GET /requests/1
  # def show
  #   redirect_to controller: :requests, action: :show
  #   # @request = Request.find(params[:id])
  # end

  def complete
    @request = Request.find(params[:id])
    return if current_user.id != (@request.created_by)

    @request.status = 'Completed'
    @request.save
    redirect_to '/myrequests', notice: 'Request marked as completed'
  end

  def accept
    @reqapp = RequestApplication.find(params[:id])
    # @request = Request.find(@reqapp.request_id)
    @request =
      Request.includes(:request_applications)
             .where(id: @reqapp.request_id)
             .left_outer_joins(:request_applications)
             .group('requests.id')
             .select('requests.*,
             COUNT(request_applications.id) as application_count,
             COUNT(CASE WHEN request_applications.status = \'Accepted\' THEN 1 END) as accepted_application_count,
          array_agg(request_applications.applicant_id) as applicant_ids').first
    return if current_user.id != @request.created_by

    @reqapp.status = "Accepted"
    if @reqapp.save
      update_counts(@request)
      respond_to do |format|
        format.html { redirect_to '/myrequests', notice: 'Application accepted' }
        format.json { render json: { 
          status: "Accepted", 
          acceptedCount: @request.accepted_application_count,
          numberOfPax: @request.number_of_pax 
        } }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/myrequests', alert: 'Failed to accept application' }
        format.json { render json: { error: 'Failed to accept application' }, status: :unprocessable_entity }
      end
    end
  end
  
  def reject
    @reqapp = RequestApplication.find(params[:id])
    @request =
      Request.includes(:request_applications)
             .where(id: @reqapp.request_id)
             .left_outer_joins(:request_applications)
             .group('requests.id')
             .select('requests.*,
             COUNT(request_applications.id) as application_count,
             COUNT(CASE WHEN request_applications.status = \'Accepted\' THEN 1 END) as accepted_application_count,
          array_agg(request_applications.applicant_id) as applicant_ids').first
    return if current_user.id != @request.created_by
    @reqapp.status = "Rejected"
    if @reqapp.save
      update_counts(@request)
      respond_to do |format|
        format.html { redirect_to '/myrequests', notice: 'Application rejected' }
        format.json { render json: { 
          status: "Rejected", 
          acceptedCount: @request.accepted_application_count,
          numberOfPax: @request.number_of_pax 
        } }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/myrequests', alert: 'Failed to reject application' }
        format.json { render json: { error: 'Failed to reject application' }, status: :unprocessable_entity }
      end
    end
  end

  private

  def update_counts(request)
    accepted_count = request.request_applications.where(status: 'Accepted').count
    request.update(accepted_application_count: accepted_count)

  end
end
