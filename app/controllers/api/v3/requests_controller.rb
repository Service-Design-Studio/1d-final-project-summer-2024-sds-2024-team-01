require 'date'

class Api::V3::RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit destroy]
  skip_before_action :authenticate_user!

  # GET /requests
  # list all requests
  def index
    # @requests = Request.includes(:user).all
    @requests_active = Request.where("date > ? OR (date = ? AND start_time > ?)", Date.today, Date.today, Time.now)
                       .where.not(status: 'Completed')
                       .order(created_at: :desc)
    
    #json format
    render json: @requests_active
  end

  # GET /requests/1
  # show a single request
  def show
    @request = Request.find(params[:id])
    @is_creator = current_user && @request.created_by == current_user.id
    @accepted_application_count = @request.request_applications.where(status: 'Accepted').count
    @slots_remaining = @request.number_of_pax - @accepted_application_count

    # Fetch the user who created the request
    @requester = User.find(@request.created_by)
    
    # Fetch reviews and calculate average rating
    @reviews_received = @requester.received_reviews
    @average_rating = @reviews_received.average(:rating).to_f.round(1)
    @review_count = @reviews_received.count
    
    render json: @request.as_json.merge(
      is_creator: @is_creator,
      slots_remaining: @slots_remaining,
      requester: @requester,
      average_rating: @average_rating,
      review_count: @review_count
    )
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
    if RequestApplication.find_by(applicant_id: current_user.id, request_id: @request.id).nil?
      @application = RequestApplication.new
      @application.applicant_id = current_user.id
      @application.request_id = @request.id
      @application.created_at = DateTime.now
      @application.updated_at = DateTime.now
      @application.status = 'Pending'

      if @application.save
        redirect_to @request, notice: 'Successfully applied for the request.'
      else
        redirect_to @request, notice: 'Failed to apply for this request'
      end
    else
      redirect_to @request, alert: 'You have already applied for this request.'
    end
  end

  # GET /requests/1/edit
  # show a form to edit a request
  def edit; end

  # POST /requests
  # create a new request
  def create
    user = auth_with_phone_and_password
    if user
      @request = Request.new(request_params)
      if @request.nil?
        puts "Request is nil after initialization"
        render json: { error: 'Failed to create request' }, status: :unprocessable_entity
        return
      end
      @request.status = 'Available'
      @request.created_by = user.id
      @request.created_at = DateTime.now
      @request.updated_at = DateTime.now
    end
    p @request
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
      render json: { message: 'Failed to create request.' }, status: :unprocessable_entity
    end
  end

  def update
    user = auth_with_phone_and_password
    if user
      @request = Request.find(params[:id])
      if @request.update(request_params)
        render json: { message: 'Request was successfully updated.' }, status: :ok
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
    @request = Request.find(params[:id])
    if @request
      if @request.destroy
        render json: { message: 'Request was successfully deleted.'}, status: :ok
      else
        render json: { message: 'Failed to delete request.' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Request not found.' }, status: :not_found
    end
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:phone_number, :password, :title, :description, :category, :location, :date, :start_time, :number_of_pax, :duration,
                                    :reward_type, :reward)
  end

  def auth_with_phone_and_password
    phone_number = params[:phone_number]
    password = params[:password]

    user = User.find_by(number: phone_number)
    user&.valid_password?(password) ? user : nil
  end
end
