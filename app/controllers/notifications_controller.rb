# require "uri"
# require "net/http"

class NotificationsController < ApplicationController
  def read
    notification = Notification.find(params[:id])
    notification.read = true
    notification.save
  end
end
