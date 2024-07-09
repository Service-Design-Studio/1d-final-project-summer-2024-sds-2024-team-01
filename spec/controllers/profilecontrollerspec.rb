# # spec/controllers/profile_controller_spec.rb
# require 'rails_helper'

# RSpec.describe ProfileController, type: :controller do
#   before do
#     @user = FactoryBot.create(:user)
#     sign_in @user
#   end

#   describe 'GET #index' do
#     context 'when id is nil' do
#       it 'assigns @profile to current_user' do
#         get :index
#         expect(assigns(:profile)).to eq(@user)
#       end
#     end

#     context 'when id is provided' do
#       it 'assigns @profile to the specified user' do
#         another_user = FactoryBot.create(:user)
#         get :index, params: { id: another_user.id }
#         expect(assigns(:profile)).to eq(another_user)
#       end
#     end

#     it 'assigns @reviews and @reviews_given' do
#       review = FactoryBot.create(:review, review_by: @user.id, review_for: @user.id)
#       get :index
#       expect(assigns(:reviews)).to eq([review])
#       expect(assigns(:reviews_given)).to eq([review])
#     end
#   end
# end
