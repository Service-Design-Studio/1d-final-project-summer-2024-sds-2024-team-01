class Api::V2::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update]
  before_action :set_request, only: [:new, :create]

  def index
    @reviews = Review.all
    render json: @reviews
  end
  def new
    @review = Review.new
    render json: @review
  end
  
  def create
    @request = Request.find(params[:myrequest_id])
    review_for_user = User.find(@request.created_by)
    # review_by_user = User.find(current_user.id)
    review_by_user = current_user
    @review = Review.new(review_params.merge(request: @request, review_by: review_by_user, review_for: review_for_user))
    # p "REVIEW = ID: #{@review.id}, RATING: #{@review.rating}, COMMENT: #{@review.review_content}, REQUEST_ID: #{@review.request_id}, REVIEW_FOR: #{@review.review_for}, REVIEW_BY: #{review_by_user}"
    if @review.save
      render json: @request, notice: "Review was successfully created."
    else
      render json: { error: "Unable to create review."}
    end
  end

  def update
    if @review.update(review_params)
      render json: @request.review, notice: 'Review was successfully updated.'
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end
  
  def edit
    @review = Request.find(params[:myrequest_id]).reviews.find(params[:id])
    render json: @review
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_request
    @request = Request.find(params[:myrequest_id])
  end

  def review_params
    params.require(:review).permit(:rating, :review_content, :review_by, :review_for, :request_id)
  end
end