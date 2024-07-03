class MyRequestsController < ApplicationController
  def index
    @requests = Request.includes(:user).all
  end

  # GET /requests/1
  def show
    @request = Request.find(params[:id])
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

end
