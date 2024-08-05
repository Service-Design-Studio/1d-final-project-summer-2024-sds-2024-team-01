require 'rails_helper'

RSpec.describe Admin::CharitiesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:charity) { create(:charity) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: charity.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #approve' do
    it 'approves the charity' do
      patch :approve, params: { id: charity.id }
      charity.reload
      expect(charity.status).to eq('Active')
      expect(response).to redirect_to(admin_charities_path)
    end
  end

  describe 'PATCH #disable' do
    it 'disables the charity' do
      patch :disable, params: { id: charity.id }
      charity.reload
      expect(charity.status).to eq('Inactive')
      expect(response).to redirect_to(admin_charities_path)
    end
  end

  describe 'PATCH #reject' do
    it 'rejects the charity' do
      patch :reject, params: { id: charity.id }
      charity.reload
      expect(charity.status).to eq('Rejected')
      expect(response).to redirect_to(admin_charities_path)
    end
  end
end
