# spec/controllers/profile_controller_spec.rb

require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  describe 'GET #index' do
    context 'when user is authenticated' do
      let(:user) { create(:random_user) }
      let(:other_user) { create(:random_user) }

      before do
        sign_in user
        get :index
      end

      it 'assigns @profile to current_user' do
        expect(assigns(:profile)).to eq(user)
      end

      it "assigns @requests for the current user's created requests" do
        expect(assigns(:requests)).to match_array(user.requests)
      end

      it "assigns @reviews_received for the current user's received reviews" do
        expect(assigns(:reviews_received)).to match_array(user.received_reviews)
      end

      it 'assigns @average_rating as nil when no reviews received' do
        expect(assigns(:average_rating)).to be_nil
      end

      it 'shows the profile of another user when the id is specified' do
        get :index, params: { id: other_user.id }
        expect(assigns(:profile)).to eq(other_user)
      end
      # Add more specific tests as needed
    end

    context 'when user is not authenticated' do
        let(:other_user) { create(:random_user) }

      before do
        get :index
      end

      it 'redirects to login page' do
        expect(response).to redirect_to('/login')
      end

      it 'shows the profile of another user when the id is specified' do
        get :index, params: { id: other_user.id }
        expect(assigns(:profile)).to eq(other_user)
      end
    end
  end
  #
  # describe 'GET #edit' do
  #   it 'returns http success' do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end

  # Add more specific tests as needed
  # end
end
