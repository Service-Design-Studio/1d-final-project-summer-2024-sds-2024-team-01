# require "uri"
# require "net/http"

class ProfileController < ApplicationController
  def index
    if params[:id] == nil then
      @profile = current_user
    else
      @profile = User.find(params[:id])
    end
    @requests = Request.includes(:user)
    @reviews = Review.where(review_by: @profile.id).all
    @reviews_given = Review.where(review_for: @profile.id).all
  end

  def edit
  end
  def destroy
  end
end
