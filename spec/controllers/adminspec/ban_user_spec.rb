require 'rails_helper'

RSpec.describe Admin::BanUserController, type: :controller do
  let(:admin_role) { create(:role, role_name: 'Admin') }
  let(:admin_user) { create(:user, role: admin_role) }
  let(:user_role) { create(:role, role_name: 'User') }
  let(:user) { create(:user, role: user_role) }
  let(:reported_user) { create(:user, role: user_role) }
  let!(:under_review_report) { create(:user_report, reported_user: reported_user, reported_by: admin_user, status: 'under_review') }
  let!(:banned_report) { create(:user_report, reported_user: reported_user, reported_by: admin_user, status: 'ban') }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'assigns under_review_users and banned_users' do
      get :index
      expect(assigns(:under_review_users)).to include(reported_user)
      expect(assigns(:banned_users)).to include(reported_user)
    end
  end

  describe 'POST #ban' do
    it 'bans the user and returns success' do
      post :ban, params: { id: reported_user.id }
      reported_user.reload
      expect(reported_user.user_reports_as_reported_user.find_by(status: 'ban')).to be_present
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['success']).to be true
    end

    it 'returns failure if the report is not found' do
      post :ban, params: { id: user.id }
      expect(JSON.parse(response.body)['success']).to be false
    end
  end

  describe 'POST #unban' do
    it 'unbans the user and returns success' do
      post :unban, params: { id: reported_user.id }
      reported_user.reload
      expect(reported_user.user_reports_as_reported_user.find_by(status: 'normal')).to be_present
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['success']).to be true
    end

    it 'returns failure if the report is not found' do
      post :unban, params: { id: user.id }
      expect(JSON.parse(response.body)['success']).to be false
    end
  end

  describe 'POST #cancel_ban' do
    it 'cancels the ban and returns success' do
      post :cancel_ban, params: { id: reported_user.id }
      reported_user.reload
      expect(reported_user.user_reports_as_reported_user.find_by(status: 'normal')).to be_present
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['success']).to be true
    end

    it 'returns failure if the report is not found' do
      post :cancel_ban, params: { id: user.id }
      expect(JSON.parse(response.body)['success']).to be false
    end
  end
end
