require 'rails_helper'

RSpec.describe UserReportsController, type: :controller do
  let(:user) { create(:user) }
  let(:reported_user) { create(:user) }
  let(:valid_attributes) { { report_reason: 'Inappropriate behavior' } }
  let(:invalid_attributes) { { report_reason: '' } }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { reported_user: reported_user.id }
      expect(response).to be_successful
      expect(assigns(:user)).to eq(reported_user)
      expect(assigns(:report)).to be_a_new(UserReport)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new UserReport' do
        expect {
          post :create, params: { user_report: valid_attributes.merge(reported_user: reported_user.id) }
        }.to change(UserReport, :count).by(1)
      end

      it 'updates the status of the reported user to under_review' do
        post :create, params: { user_report: valid_attributes.merge(reported_user: reported_user.id) }
        reported_user.reload
        expect(reported_user.status).to eq('under_review')
      end

      it 'redirects to the requests path with a success notice' do
        post :create, params: { user_report: valid_attributes.merge(reported_user: reported_user.id) }
        expect(response).to redirect_to(requests_path)
        expect(flash[:notice]).to eq('User has been reported successfully.')
      end
    end

    context 'with invalid params' do
      it 'does not create a new UserReport' do
        expect {
          post :create, params: { user_report: invalid_attributes.merge(reported_user: reported_user.id) }
        }.to change(UserReport, :count).by(0)
      end

      it 'renders the new template' do
        post :create, params: { user_report: invalid_attributes.merge(reported_user: reported_user.id) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #confirm' do
    it 'returns a success response' do
      get :confirm, params: { user_report: valid_attributes.merge(reported_user: reported_user.id) }
      expect(response).to be_successful
      expect(assigns(:user)).to eq(reported_user)
      expect(assigns(:report_reason)).to eq(valid_attributes[:report_reason])
    end
  end
end
