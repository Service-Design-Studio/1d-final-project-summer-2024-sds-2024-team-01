require 'rails_helper'

RSpec.describe Admin::BanUserController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:under_review_report) { create(:user_report, reported_user: user, status: 'under_review') }
  let(:banned_report) { create(:user_report, reported_user: user, status: 'ban') }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns under review users and banned users' do
      under_review_report
      banned_report
      get :index
      expect(assigns(:under_review_users)).to include(user)
      expect(assigns(:banned_users)).to include(user)
    end
  end

  describe 'PATCH #ban' do
    it 'bans the user' do
      patch :ban, params: { id: user.id }
      user.reload
      expect(user.status).to eq('banned')
    end
  end

  describe 'PATCH #unban' do
    it 'unbans the user' do
      user.update(status: 'banned')
      patch :unban, params: { id: user.id }
      user.reload
      expect(user.status).to eq('normal')
    end
  end

  describe 'PATCH #cancel_ban' do
    it 'cancels the ban' do
      user.update(status: 'banned')
      patch :cancel_ban, params: { id: user.id }
      user.reload
      expect(user.status).to eq('normal')
    end
  end
end
