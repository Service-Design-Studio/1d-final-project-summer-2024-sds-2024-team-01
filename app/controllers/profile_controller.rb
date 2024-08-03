# require "uri"
# require "net/http"

class ProfileController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_user, only: %i[edit update]
  
  def index
    if params[:id].nil?
      if current_user.nil?
        redirect_to '/login'
        return
      else
        @profile = current_user
      end
    else
      @profile = User.find(params[:id])
    end

    @requests = Request.where(created_by: @profile.id)
                   .order(Arel.sql("CASE status WHEN 'Available' THEN 0 WHEN 'Completed' THEN 1 ELSE 2 END"), :date)
    @reviews_received = @profile.received_reviews.includes(:review_by, :request)

    @reviews_from_requesters = @reviews_received.select do |review|
      review.review_by == review.request.created_by
    end

    @reviews_from_applicants = @reviews_received.select do |review|
      review.review_by != review.request.created_by
    end

    @average_rating = @reviews_received.average(:rating)
  end

  def edit
    # This action will render the edit form
  end

  def update
    if @profile.update(user_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @profile = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :number, :description, :charity_id, :company_id, :role_id)
  end
end
