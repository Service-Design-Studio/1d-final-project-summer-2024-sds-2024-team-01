class MyRequestsController < ApplicationController
  def index
    @requests = Request.includes(:request_applications)
                       .where(created_by: current_user.id)
                       .left_outer_joins(:request_applications)
                       .group('requests.id')
                       .select('requests.*,
                                COUNT(request_applications.id) as total_application_count,
                                COUNT(CASE WHEN request_applications.status != \'Withdrawn\' THEN 1 END) as active_application_count,
                                COUNT(CASE WHEN request_applications.status = \'Accepted\' THEN 1 END) as accepted_application_count,
                                array_agg(request_applications.applicant_id) as applicant_ids')

    today_start = Date.today.beginning_of_day
    @in_progress_requests = @requests.where('date > ?', today_start)
                                     .where.not(status: 'Completed')
    @completed_requests = @requests.where(status: 'Completed')
    @unfulfilled_requests = @requests.where('date <= ?', today_start)
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

    @applications = RequestApplication.where(request_id: params[:id])
    @pendingapplications = @applications.where.not(status: 'Accepted').where.not(status: 'Rejected')
    @acceptedapplications = @applications.where(status: 'Accepted')

    @acceptedapplications.each do |accepted|
      @notification = Notification.new
      @notification.message = 'Congratulations! You\'ve helped to complete a request! Click here to view.'
      @notification.url = '/myapplications'
      @notification.header = 'Request Completed'
      @notification.notification_for = User.find(accepted.applicant_id)
      @notification.save
    end

    @pendingapplications.each do |pending|
      pending.status = 'Rejected'
      pending.save
    end

    @request.status = 'Completed'
    @request.save
    redirect_to '/myrequests', flash: { success: "Congratulations! Your request is marked as complete!" } 
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


    @reqapp.status = 'Accepted'
    if @reqapp.save
      @notification = Notification.new
      @notification.message = 'Your application for a request has been accepted! Click here to view.'
      @notification.url = '/myapplications'
      @notification.header = 'Application accepted'
      @notification.notification_for = User.find(@reqapp.applicant_id)
      @notification.save

      update_counts(@request)
      respond_to do |format|
        format.html { redirect_to '/myrequests', notice: 'Application accepted' }
        format.json do
          render json: {
            status: 'Accepted',
            acceptedCount: @request.accepted_application_count,
            numberOfPax: @request.number_of_pax
          }
        end
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


    @reqapp.status = 'Rejected'
    if @reqapp.save
      @notification = Notification.new
      @notification.message = 'Your application for a request has been rejected. Click here to view.'
      @notification.url = '/myapplications'
      @notification.header = 'Application rejected'
      @notification.notification_for = User.find(@reqapp.applicant_id)
      @notification.save

      update_counts(@request)
      respond_to do |format|
        format.html { redirect_to '/myrequests', notice: 'Application rejected' }
        format.json do
          render json: {
            status: 'Rejected',
            acceptedCount: @request.accepted_application_count,
            numberOfPax: @request.number_of_pax
          }
        end
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

  def handle_pending_applications
    current_time = Time.current
    pending_applications = RequestApplication.includes(:request, :applicant)
                                             .where(status: 'Pending')

    pending_applications.each do |application|
      request_time = application.request.date.to_time + application.request.start_time.seconds_since_midnight.seconds
      time_until_request = request_time - current_time

      case
      when time_until_request <= 12.hours
        auto_reject_application(application)
      when time_until_request <= 18.hours
        send_warning_notifications(application, '18 hours')
      when time_until_request <= 24.hours
        send_warning_notifications(application, '24 hours')
      end
    end
  end

  def auto_reject_application(application)
    application.update(status: 'Rejected')
    
    create_notification(
      application.applicant,
      'Your application has been automatically rejected as the request date is approaching.',
      '/myapplications',
      'Application Auto-Rejected'
    )

    create_notification(
      application.request.user,
      "An application for your request '#{application.request.title}' has been automatically rejected.",
      "/requests/#{application.request.id}",
      'Application Auto-Rejected'
    )
  end

  def send_warning_notifications(application, time_left)
    create_notification(
      application.request.user,
      "You have a pending application for your request '#{application.request.title}'. It will be auto-rejected in #{time_left}.",
      "/requests/#{application.request.id}",
      'Application Auto-Rejection Warning'
    )

    create_notification(
      application.applicant,
      "Your application for '#{application.request.title}' is still pending. It may be auto-rejected in #{time_left}.",
      '/myapplications',
      'Application Status Warning'
    )
  end

  def create_notification(user, message, url, header)
    Notification.create(
      notification_for: user,
      message: message,
      url: url,
      header: header,
      read: false
    )
  end
end
