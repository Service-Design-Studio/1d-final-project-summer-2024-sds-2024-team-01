require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:notification1) { create(:test_notification, notification_for: user, read: false) }
  let!(:notification2) { create(:test_notification, notification_for: user, read: false) }

  before do
    sign_in user
  end

  describe 'post #read' do
    it 'marks the notification as read' do
      post :read, params: { id: notification1.id }
      notification1.reload
      expect(notification1.read).to be true
    end

    it 'returns a successful response' do
      post :read, params: { id: notification1.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #clear' do
    it 'marks all unread notifications as read for the current user' do
      post :clear
      notification1.reload
      notification2.reload
      expect(notification1.read).to be true
      expect(notification2.read).to be true
    end

    it 'returns a successful response' do
      post :clear
      expect(response).to have_http_status(:success)
    end
  end
end

