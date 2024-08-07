require 'rails_helper'

RSpec.describe UserReportsController, type: :controller do
  let(:user) { create(:user) }
  let(:reported_user) { create(:user) }
  let(:valid_attributes) { { report_reason: 'Inappropriate behavior', reported_user: reported_user.id } }
  let(:invalid_attributes) { { report_reason: '', reported_user: reported_user.id } }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new user_report as @report' do
      get :new, params: { reported_user: reported_user.id }
      expect(assigns(:report)).to be_a_new(UserReport)
      expect(response).to render_template(partial: '_new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new UserReport' do
        expect {
          post :create, params: { user_report: valid_attributes }
        }.to change(UserReport, :count).by(1)
      end

      it 'redirects to the requests path' do
        post :create, params: { user_report: valid_attributes }
        expect(response).to redirect_to(requests_path)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user_report as @report' do
        post :create, params: { user_report: invalid_attributes }
        expect(assigns(:report)).to be_a_new(UserReport)
      end

      it 're-renders the new partial' do
        post :create, params: { user_report: invalid_attributes }
        expect(response).to render_template(partial: '_new')
      end
    end
  end

  describe 'GET #confirm' do
    it 'assigns the requested user as @user' do
      get :confirm, params: { user_report: { reported_user: reported_user.id, report_reason: 'Inappropriate behavior' } }
      expect(assigns(:user)).to eq(reported_user)
      expect(assigns(:report_reason)).to eq('Inappropriate behavior')
    end
  end

    it 'responds to html and js formats' do
      get :confirm, params: { user_report: { reported_user: reported_user.id, report_reason: 'Inappropriate behavior' } }, format: :html
      expect(response).to render_template(partial: '_confirm')

    #   get :confirm, params: { user_report: { reported_user: reported_user.id, report_reason: 'Inappropriate behavior' } }, format: :js
    #   expect(response.content_type).to eq('text/javascript')
    
  end
end
