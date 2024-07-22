require 'rails_helper'

RSpec.describe BanUserController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  before do
    sign_in admin
  end

  describe 'PATCH #ban' do
    it 'bans the user' do
      patch :ban, params: { id: user.id, ban_reason: 'Violation of rules' }
      user.reload
      expect(user.banned).to be_truthy
      expect(user.ban_reason).to eq('Violation of rules')
      expect(response).to redirect_to(ban_user_index_path)
    end
  end

  describe 'PATCH #unban' do
    it 'unbans the user' do
      user.update(banned: true, ban_reason: 'Violation of rules')
      patch :unban, params: { id: user.id }
      user.reload
      expect(user.banned).to be_falsey
      expect(user.ban_reason).to be_nil
      expect(response).to redirect_to(ban_user_index_path)
    end
  end
end
