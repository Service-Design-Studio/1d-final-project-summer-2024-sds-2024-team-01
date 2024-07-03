# require "uri"
# require "net/http"

class ProfileController < ApplicationController
  def index
    if params[:id] == nil then
      @profile = current_user
    else
      @profile = User.find(params[:id])
    end

    @reviews = Review.where(review_by: @profile.id).all
    @reviews_given = Review.where(review_for: @profile.id).all
  end


  # GET /requests/1
  def show
    @user = User.find(params[:id])
    @requests = @user.requests
  end  


  def edit
  end
  def destroy
  end
end
