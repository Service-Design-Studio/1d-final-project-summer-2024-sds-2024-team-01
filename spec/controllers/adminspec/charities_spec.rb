require 'rails_helper'

RSpec.describe Admin::CharitiesController, type: :controller do
  let(:admin) { create(:admin_user) }
  let(:charity) { create(:charity) }
  let(:charity_user) { create(:user, role_id: 5, charity: charity) }

  before do
    sign_in admin
    ActionMailer::Base.deliveries.clear # Clear previous deliveries
  end

  describe 'GET #index' do
    it 'assigns active, inactive, and rejected charities' do
      active_charity = create(:charity, status: 'Active')
      inactive_charity = create(:charity, status: 'Inactive')
      rejected_charity = create(:charity, status: 'Rejected')

      get :index

      expect(assigns(:active_charities)).to include(active_charity)
      expect(assigns(:inactive_charities)).to include(inactive_charity)
      expect(assigns(:rejected_charities)).to include(rejected_charity)
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'assigns the requested charity' do
      get :show, params: { id: charity.id }

      expect(assigns(:charity)).to eq(charity)
      expect(response).to be_successful
    end
  end

  describe 'PATCH #approve' do
    it 'approves the charity and sends an approval email' do
      allow(SecureRandom).to receive(:hex).and_return('unique_code')

      charity_user # Ensure the charity user is created

      patch :approve, params: { id: charity.id }

      expect(charity.reload.status).to eq('Active')
      expect(charity_user.reload.status).to eq('Active')
      expect(CharityCode.where(charity: charity, code: 'unique_code')).to exist

      # deliveries = ActionMailer::Base.deliveries
      # expect(deliveries.count).to eq(1) # Ensure an email was sent
      # expect(deliveries.last.to).to include(charity_user.email) # Make sure the email was sent to the charity user

      expect(response).to redirect_to(admin_charities_path(anchor: 'active-tab'))
      expect(flash[:notice]).to eq('Charity approved successfully and email sent.')
    end

    it 'handles errors and redirects to the inactive tab with an alert' do
      allow_any_instance_of(Charity).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)

      patch :approve, params: { id: charity.id }

      expect(response).to redirect_to(admin_charities_path(anchor: 'inactive-tab'))
      expect(flash[:alert]).to eq('There was an error approving the charity.')
    end
  end

  describe 'PATCH #disable' do
    it 'disables the charity' do
      charity.update!(status: 'Active')
      charity_user # Ensure the charity user is created

      patch :disable, params: { id: charity.id }

      expect(charity.reload.status).to eq('Inactive')
      expect(charity_user.reload.status).to eq('Inactive')
      expect(response).to redirect_to(admin_charities_path(anchor: 'inactive-tab'))
      expect(flash[:notice]).to eq('Charity disabled successfully.')
    end
  end

  describe 'PATCH #reject' do
    it 'rejects the charity' do
      charity.update!(status: 'Inactive')

      patch :reject, params: { id: charity.id }

      expect(charity.reload.status).to eq('Rejected')
      expect(response).to redirect_to(admin_charities_path(anchor: 'rejected-tab'))
      expect(flash[:notice]).to eq('Charity rejected successfully.')
    end
  end

  describe 'authentication and authorization' do
    context 'when the user is not an admin' do
      let(:non_admin) { create(:user) }

      before do
        sign_in non_admin
      end

      it 'redirects to root path with an alert' do
        get :index

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'when the user is not signed in' do
      before do
        sign_out admin
      end

      it 'redirects to the login page' do
        get :index

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

