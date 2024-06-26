require 'date'

class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]

  # GET /requests
  def index
    @requests = Request.includes(:user).all
  end

  # GET /requests/1
  def show
    @request = Request.find(params[:id])
  end

  # GET /requests/new
  def new
    @request = Request.new
  end


  # GET /requests/1/edit
  def edit
    # @request is set by the set_request method
  end

  # POST /requests
  def create
    puts params
    @request = Request.new
    @request.title = params[:title]
    @request.category = params[:category]
    @request.location = params[:location]
    @request.date = params[:date]
    @request.number_of_pax = params[:number_of_pax]
    @request.duration = params[:duration]
    @request.reward = params[:reward]
    @request.reward_type = params[:reward_type]
    @request.status = "Available"
    @request.created_by = 1
    @request.created_at = DateTime.now()
    @request.updated_at = DateTime.now()

    if @request.save
      @request.thumbnail.attach(params[:thumbnail_pic])
      redirect_to @request, notice: "Request was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /requests/1
  def update
    if @request.update(request_params)
      redirect_to @request, notice: "Request was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /requests/1
  def destroy
    @request.destroy!
    redirect_to requests_url, notice: "Request was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def request_params
      params.fetch(:request, {}).permit(:thumbnail)
    end
end
