# require "uri"
# require "net/http"

class ProfileController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    if params[:id].nil?
      if current_user.nil?
        render '/login'
      else
        @profile = current_user
      end
    else
      @profile = User.find(params[:id])
    end

    @requests = Request.where(created_by: @profile.id)
    @reviews_received = Review.where(review_for: @profile.id)
    @average_rating = @reviews_received.average(:rating)
  end

  def edit; end

  def destroy; end

  def show
    @user = User.find(params[:id])
    @average_rating = @user.received_reviews.average(:rating)
  end
  
end
