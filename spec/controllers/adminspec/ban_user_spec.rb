require 'rails_helper'

RSpec.describe Admin::BanUserController, type: :controller do
  let(:admin_user) { create(:admin_user) }
  let(:reported_user) { create(:random_user) }
  let!(:user_report) { create(:random_user_report, reported_user: reported_user) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'assigns under_review_users and banned_users' do
      get :index

      expect(assigns(:under_review_users)).to include(reported_user)
      expect(assigns(:banned_users)).to be_empty
    end
  end

  describe 'POST #ban' do
    context 'when user reports exist' do
      it 'bans the user and returns success message' do
        post :ban, params: { id: reported_user.id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Successfully banned.')
        expect(reported_user.user_reports_as_reported_user.first.status).to eq('ban')
      end
    end

    context 'when user reports do not exist' do
      before { user_report.update(status: 'ban') }

      it 'returns failure message' do
        post :ban, params: { id: reported_user.id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Ban failed.')
      end
    end
  end

  describe 'POST #unban' do
    before { user_report.update(status: 'ban') }

    context 'when user reports exist' do
      it 'unbans the user and returns success message' do
        post :unban, params: { id: reported_user.id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Successfully unbanned.')
        expect(reported_user.user_reports_as_reported_user.first.status).to eq('Active')
      end
    end

    context 'when user reports do not exist' do
      before { user_report.update(status: 'Active') }

      it 'returns failure message' do
        post :unban, params: { id: reported_user.id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Unban failed.')
      end
    end
  end

  describe 'POST #cancel_ban' do
    context 'when user reports exist' do
      it 'cancels the ban and returns success message' do
        post :cancel_ban, params: { id: reported_user.id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Successfully cancelled.')
        expect(reported_user.user_reports_as_reported_user.first.status).to eq('Active')
      end
    end

    context 'when user reports do not exist' do
      before { user_report.update(status: 'ban') }

      it 'returns failure message' do
        post :cancel_ban, params: { id: reported_user.id }, format: :json

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Cancel ban failed.')
      end
    end
  end
end
