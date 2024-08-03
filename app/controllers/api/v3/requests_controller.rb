require 'date'
# require '../app/gemini/gemini_api'
# include Gemini_Helper

class Api::V3::RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit destroy]
  skip_before_action :authenticate_user!

  # GET /requests
  # list all requests
  def index
    today_start = Date.today.beginning_of_day

    @in_progress_requests = if !current_user.nil? && current_user.role_id == 4
                              Request.includes(:user, :request_applications)
                                     .where(users: { role_id: 5 })
                                     .where(users: { charity_id: CompanyCharity.where(company_id: current_user.company_id).pluck(:charity_id) })
                                     .where('date > ?', today_start)
                                     .where(reward_type: 'None')
                                     .where.not(status: 'Completed')
                                     .order(date: :asc, start_time: :asc)
                            else
                              Request.includes(:user, :request_applications)
                                     .where('date > ?', today_start)
                                     .where.not(status: 'Completed')
                                     .order(date: :asc, start_time: :asc)
                            end

    #json format
    render json: @in_progress_requests, status: :ok
  end

  # GET /requests/1
  # show a single request
  def show
    @request = Request.find(params[:id])
    if @request.nil?
      render json: { error: 'Request does not exist.' }, status: :not_found
      return
    end

    @is_creator = current_user && @request.created_by == current_user.id
    @accepted_application_count = @request.request_applications.where(status: 'Accepted').count
    @slots_remaining = @request.number_of_pax - @accepted_application_count

    # Fetch the user who created the request
    @requester = User.find(@request.created_by)

    # Fetch reviews and calculate average rating
    @reviews_received = @requester.received_reviews
    @average_rating = @reviews_received.average(:rating).to_f.round(1)
    @review_count = @reviews_received.count

    if !current_user.nil?
      # Prepare user and request profiles for the match calculation
      user_profile = {
        name: current_user.name,
        bio: current_user.description
      }

      request_profile = {
        title: @request.title,
        description: @request.description,
        location: @request.location,
        rewards: @request.reward
      }

      # Fetch the percentage compatibility of request with user
      @match_percentage = generate_match_percentage(user_profile, request_profile)
    else
      @match_percentage = 'User is not signed in'
    end
    render json: @request.as_json.merge(
      is_creator: @is_creator,
      slots_remaining: @slots_remaining,
      requester: @requester,
      average_rating: @average_rating,
      review_count: @review_count,
      match_percentage: @match_percentage
    ), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Request not found.' }, status: :not_found
  rescue => e
    render json: { error: e.message }, status: :internal_server_error

  end
  

  # GET /requests/new
  # show a form to create a new request
  def new
    @request = Request.new
  end

  # POST /requests/apply
  # create a new request
  def apply
    @request = Request.find(params[:id])
    requester = User.find(@request.created_by)

    if current_user.role_id == 4
      allowed_charity_ids = CompanyCharity.where(company_id: current_user.company_id).pluck(:charity_id)

      can_apply = requester.role_id == 5 && allowed_charity_ids.include?(requester.charity_id)

      unless can_apply
        render json: @request, notice: 'You can only apply for requests by IPCs registered with your company'
        return
      end
    end

    if RequestApplication.where(request_id: @request.id).where(status: 'Accepted').count >= @request.number_of_pax
      render json: @request, notice: 'Sorry, this request is unable to accept anymore applicants.'
      return
    end
    if RequestApplication.find_by(applicant_id: current_user.id, request_id: @request.id).nil?
      @application = RequestApplication.new
      @application.applicant_id = current_user.id
      @application.request_id = @request.id
      @application.created_at = DateTime.now
      @application.updated_at = DateTime.now
      @application.status = 'Pending'

      @notification = Notification.new
      @notification.message = 'Someone has applied for your request! Click here to view.'
      @notification.url = '/myrequests'
      @notification.header = 'New application'
      @notification.notification_for = User.find(@request.created_by)
      @notification.save

      if @application.save
        # redirect_to @request, flash: { success: 'You have successfully applied for the request!' }
        render json: {message: 'You have successfully applied for the request!'}, status: :success
      else
        # redirect_to @request, flash: { error: 'Sorry, you have failed to apply for this request.' }
        render json:, notice: 'Sorry, you have failed to apply for this request.'
      end
    else
      # redirect_to @request, flash: { warning: 'You have already applied for this request.' }
      render json:, notice: 'You have already applied for this request.'
    end  end

  # GET /requests/1/edit
  # show a form to edit a request
  def edit; end

  # POST /requests
  # create a new request
  def create
    user = auth_with_phone_and_password
    if user
      @request = Request.new(request_params.except(:number, :password))
      if @request.nil?
        puts "Request is nil after initialization"
        render json: { error: 'Failed to create request' }, status: :unprocessable_entity
        return
      end
      @request.status = 'Available'
      @request.created_by = user.id
      @request.created_at = DateTime.now
      @request.updated_at = DateTime.now
      @request.stringlocation = params[:request][:stringlocation] if params[:request][:stringlocation].present?
    end
    # p @request
    if @request.save
      if request_params[:thumbnail].present?
        @request.thumbnail.attach(request_params[:thumbnail])
      else
        @request.thumbnail.attach(
          io: File.open(Rails.root.join('app', 'assets', 'images', 'freepik-lmao.jpg')),
          filename: 'freepik-lmao.jpg',
          content_type: 'image/jpeg'
        )
      end
      render json: { message: 'Request was successfully created.' }, status: :created
    else
      p @request
      render json: { message: 'Failed to create request.' }, status: :unprocessable_entity
    end
  end

  def update
    user = auth_with_phone_and_password
    if user
      @request = Request.find(params[:id])
      if @request.update(request_params.except(:number, :password))
        @request.updated_at = DateTime.now
        # p "Updated at:#{@request.updated_at}"
        render json: @request, status: :ok
        # p "Description:#{@request.description}"
      else
        render json: { message: 'Failed to update request.', errors: @request.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Authentication failed.' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Request not found.' }, status: :not_found
  rescue => e
    render json: { message: 'An error occurred while updating the request.', error: e.message }, status: :internal_server_error
  end
  


  # destroy request feature implmentation?
  def destroy
    user = auth_with_phone_and_password
    if user
      @request = Request.find(params[:id])
      if @request
        if @request.destroy
          render json: @in_progress_requests, status: :ok
        else
          render json: { message: 'Failed to delete request.' }, status: :unprocessable_entity
        end
      else
        render json: { message: 'Request not found.' }, status: :not_found
      end
    end
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:number, :password, :title, :description, :category, :location, :stringlocation, :date, :start_time, :number_of_pax, :duration,
                                    :reward_type, :reward)
  end

  def auth_with_phone_and_password
    phone_number = params[:request][:number]
    password = params[:request][:password]
    # p phone_number, password
    user = User.find_by(number: phone_number)
    # p user
    user&.valid_password?(password) ? user : nil
    # p "Successful"

  end
end
