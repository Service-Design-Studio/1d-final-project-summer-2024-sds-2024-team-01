# require "uri"
# require "net/http"

class ProfileController < ApplicationController
  def index
    if params[:id] == NULL then
      @profile = current_user
    else
      @profile = User.find(params[:id])
    end
  end
  def edit
  end
  def destroy
  end
end
