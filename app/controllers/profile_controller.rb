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
    @reviews = Review.where(review_by: @profile.id).all
    @reviews_given = Review.where(review_for: @profile.id).all
  end

  def edit; end

  def destroy; end
end
