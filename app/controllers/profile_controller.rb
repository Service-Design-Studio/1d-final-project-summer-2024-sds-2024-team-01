# require "uri"
# require "net/http"

class ProfileController < ApplicationController
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
    @reviews_received = @profile.received_reviews
    @average_rating = @reviews_received.average(:rating)
  end

  # def edit; end
end
