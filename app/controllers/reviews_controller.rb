class ReviewsController < ApplicationController
  before_action :set_reviewee, only: [:new, :create]
  before_action :set_review, only: [:edit, :update]
  before_action :authenticate_user!

  def new
    @review = Review.new
  end

  def create
    @review = @review_for.received_reviews.new(review_params)
    @review.created_by = current_user

    if @review.save
      redirect_to user_reviews_path(current_user), notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to user_reviews_path(current_user), notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def index
    @reviews = current_user.written_reviews
  end

  private

  def set_reviewee
    @review_for = User.find(params[:user_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
  
  def review_params
    params.require(:review).permit(:rating, :review_content)
  end
end
