class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update]
  before_action :set_request, only: [:new, :create]

  def new
    @review = Review.new
  end
  
  def create
    @request = Request.find(params[:myrequest_id])
    review_for_user = User.find(@request.created_by)
    # review_by_user = User.find(current_user.id)
    review_by_user = current_user
    @review = Review.new(review_params.merge(request: @request, review_by: review_by_user, review_for: review_for_user))
    # p "REVIEW = ID: #{@review.id}, RATING: #{@review.rating}, COMMENT: #{@review.review_content}, REQUEST_ID: #{@review.request_id}, REVIEW_FOR: #{@review.review_for}, REVIEW_BY: #{review_by_user}"
    if @review.save
      redirect_to @request, flash: { success: "Review saved! Thank you for your contributions!" }
    else
      p @review.errors.full_messages
      render :new, flash: { error: "There was an error with uploading your review." }
    end
  end

  def update
    if @review.update(review_params)
      redirect_to request_path(@review.request), flash: { success: "Your review has been updated successfully!" }
    else
      render :edit
    end
  end
  
  def edit
    @review = Request.find(params[:myrequest_id]).reviews.find(params[:id])
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
