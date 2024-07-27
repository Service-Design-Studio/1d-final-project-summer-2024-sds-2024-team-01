# spec/controllers/admin/ban_user_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::BanUserController, type: :controller do
  let(:admin) { create(:user, role: create(:role, role_name: 'Admin')) }
  let(:user) { create(:user) }
  let!(:under_review_report) { create(:user_report, reported_user: user, status: 'under_review') }
  let!(:ban_report) { create(:user_report, reported_user: user, status: 'ban') }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'assigns reported and banned users' do
      get :index
      expect(assigns(:reported_users)).to include(user)
      expect(assigns(:banned_users)).to include(user)
    end
  end

  describe 'POST #ban' do
    it 'changes user report status to ban' do
      post :ban, params: { id: user.id }
      expect(user.user_reports.where(status: 'ban').count).to eq 1
      expect(response).to redirect_to(admin_ban_user_index_path)
    end
  end

  describe 'POST #unban' do
    it 'changes user report status to normal' do
      post :unban, params: { id: user.id }
      expect(user.user_reports.where(status: 'normal').count).to eq 1
      expect(response).to redirect_to(admin_ban_user_index_path)
    end
  end
end
