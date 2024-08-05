require 'rails_helper'

RSpec.describe Admin::BanUserController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #ban' do
    it 'bans the user' do
      post :ban, params: { id: user.id }
      user.reload
      expect(user.status).to eq('ban')
      expect(response).to be_successful
    end
  end

  describe 'POST #unban' do
    it 'unbans the user' do
      post :unban, params: { id: user.id }
      user.reload
      expect(user.status).to eq('Active')
      expect(response).to be_successful
    end
  end

  describe 'POST #cancel_ban' do
    it 'cancels the ban' do
      post :cancel_ban, params: { id: user.id }
      user.reload
      expect(user.status).to eq('Active')
      expect(response).to be_successful
    end
  end
end
