# require "uri"
# require "net/http"

class NotificationsController < ApplicationController
  def read
    notification = Notification.find(params[:id])
    notification.read = true
    notification.save
  end

  def clear
    unreadnotifs = Notification.where(notification_for: current_user.id).where(read: false)
    unreadnotifs.each do |notif|
      notif.read = true
      notif.save
    end
  end
end
