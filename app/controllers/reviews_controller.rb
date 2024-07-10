class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update]
  before_action :set_request, only: [:new, :create]

  def new
    @review = Review.new
  end
  
  def create
    @request = Request.find(params[:myrequest_id])
    p "Found request: #{@request.inspect}"

    @review = Review.new(review_params)
    p "New review created: #{@review.inspect}"

    @review.request = @request
    p "Set request_id: #{@review.request_id}"

    @review.created_by = current_user
    p "Set created_by: #{@review.created_by}"

    @review.review_for = @request.user
    p "Set review_for: #{@review.review_for}"
    
    @review.created_at = DateTime.now
    @review.updated_at = DateTime.now
    if @review.save
      redirect_to @request, notice: "Review was successfully created."
    else
      p @review.errors.full_messages
      render :new, notice: 'Review not saved.'
    end
  end

  def update
    if @review.update(review_params)
      redirect_to request_path(@review.request), notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end
  
  def edit
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_request
    @request = Request.find(params[:myrequest_id])
  end

  def review_params
    params.require(:review).permit(:rating, :review_content)#, :created_by, :review_for, :request_id)
  end
end