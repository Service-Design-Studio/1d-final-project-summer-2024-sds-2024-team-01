class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[edit update]
  before_action :set_application, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @requestapp = RequestApplication.find(params[:request_application_id])
    # review_by_user = User.find(current_user.id)
    review_by_user = current_user
    if current_user.id == @requestapp.request.created_by
      review_for_user = User.find(@requestapp.applicant.id)
      redir = '/myrequests'
    else
      review_for_user = User.find(@requestapp.request.created_by)
      redir = '/myapplications'
    end
    @review = Review.new(review_params.merge(request: @requestapp.request, review_by: review_by_user,
                                             review_for: review_for_user))
    # p "REVIEW = ID: #{@review.id}, RATING: #{@review.rating}, COMMENT: #{@review.review_content}, REQUEST_ID: #{@review.request_id}, REVIEW_FOR: #{@review.review_for}, REVIEW_BY: #{review_by_user}"
    if @review.save

      @notification = Notification.new
      @notification.message = 'Someone left a review on your profile! Click here to view.'
      @notification.url = '/profile'
      @notification.header = 'Someone left you a review'
      @notification.notification_for = @review.review_for
      @notification.save

      redirect_to redir, notice: 'Review was successfully created.'

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

  def set_application
    @application = RequestApplication.find(params[:request_application_id])
  end

  def review_params
    params.require(:review).permit(:rating, :review_content, :review_by, :review_for, :request_application_id)
  end
end
