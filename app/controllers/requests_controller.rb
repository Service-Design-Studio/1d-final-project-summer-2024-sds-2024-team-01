require 'date'
require_relative '../gemini/gemini_api'
include Gemini_Helper

class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /requests
  # list only active requests

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

    respond_to do |format|
      format.html
      format.json { render json: @in_progress_requests }
    end
  end

  # GET /requests/1
  # show a single request
  def show
    if @request.nil?
      redirect_to '/', notice: 'This request does not exist'
      return
    end

    @is_creator = current_user && @request.created_by == current_user.id
    @accepted_application_count = @request.request_applications.where(status: 'Accepted').count
    @slots_remaining = [@request.number_of_pax - @accepted_application_count, 0].max

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

    #   Fetch the percentage compatibility of request with user
      @match_percentage = generate_match_percentage(user_profile, request_profile)
    else
      @match_percentage = 'User is not signed in'
    end
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
        redirect_to @request, notice: 'You can only apply for requests by IPCs registered with your company'
        return
      end
    end

    if RequestApplication.where(request_id: @request.id).where(status: 'Accepted').count >= @request.number_of_pax
      redirect_to @request, notice: 'Sorry, this request is unable to accept anymore applicants.'
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
        redirect_to @request, notice: 'You have successfully applied for the request!'
      else
        # redirect_to @request, flash: { error: 'Sorry, you have failed to apply for this request.' }
        redirect_to @request, notice: 'Sorry, you have failed to apply for this request.'
      end
    else
      # redirect_to @request, flash: { warning: 'You have already applied for this request.' }
      redirect_to @request, notice: 'You have already applied for this request.'
    end
  end

  # GET /requests/1/edit
  # show a form to edit a request
  def edit; end

  def update
    if @request.update(request_params)
    redirect_to @request, notice: 'Request was successfully updated.'
    else
      render :edit
    end
  end

  # POST /requests
  # create a new request
  def create
    @request = Request.new(request_params)
    @request.status = 'Available'
    @request.created_by = current_user.id
    @request.created_at = DateTime.now
    @request.updated_at = DateTime.now
    @request.stringlocation = params[:request][:stringlocation] if params[:request][:stringlocation].present?

    if @request.save
      if request_params[:thumbnail].present?
        @request.thumbnail.attach(request_params[:thumbnail])
        #   else
        #     @request.thumbnail.attach(
        #       io: File.open(Rails.root.join('app', 'assets', 'images', 'freepik-lmao.jpg')),
        #       filename: 'freepik-lmao.jpg',
        #       content_type: 'image/jpeg'
        #     )
      end
      redirect_to @request, notice: 'Request was successfully created.'
      # redirect_to @request, flash: { success: 'Request was successfully created.' }
    else
      puts @request.errors.full_messages
      flash.now[:alert] = 'Invalid information inserted. Please try again'
      render :new, status: :unprocessable_entity
    end
  end

  # destroy request feature implmentation?
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:title, :description, :category, :location, :date, :start_time, :number_of_pax,
                                    :duration, :reward_type, :reward, :thumbnail)
    # params.fetch(:request, {}).permit(:thumbnail)
  end
end
