# require "uri"
# require "net/http"

class ProfileController < ApplicationController
  def index
    @profile = if params[:id].nil?
                 current_user
               else
                 User.find(params[:id])
               end
    @requests = Request.where(created_by: @profile.id)
    @reviews = Review.where(review_by: @profile.id).all
    @reviews_given = Review.where(review_for: @profile.id).all
    @requests = @profile.requests
  end

  def edit; end

  def destroy; end
end
