
require 'date'

class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /requests
  #list all requests
  def index
    @requests = Request.includes(:user).all
  end

  # GET /requests/1
  #show a single request
  def show
    @request = Request.find(params[:id])
  end

  # GET /requests/new
  #show a form to create a new request
  def new
    @request = Request.new
  end

  # POST /requests/apply
  #create a new request
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
  #show a form to edit a request
  def edit; end

  # POST /requests
  #create a new request
  def create
    @request = Request.new(request_params)
    @request.status = 'Available'
    @request.created_by = current_user.id
    @request.created_at = DateTime.now
    @request.updated_at = DateTime.now

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
      redirect_to @request, notice: 'Request was successfully created.'
    else
      puts @request.errors.full_messages
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
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:title, :description, :category, :location, :date, :start_time, :number_of_pax, :duration,
                                    :reward_type, :reward, :thumbnail)
    # params.fetch(:request, {}).permit(:thumbnail)
  end

  
end
