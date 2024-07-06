# # spec/controllers/my_devise/registrations_controller_spec.rb
# require 'rails_helper'

# RSpec.describe MyDevise::RegistrationsController, type: :controller do
#   describe "POST #create" do
#     let(:valid_attributes) { attributes_for(:user) }

#     context "with valid params" do
#       it "creates a new User" do
#         expect {
#           post :create, params: { user: valid_attributes }
#         }.to change(User, :count).by(1)
#       end

#       it "redirects to the home page" do
#         post :create, params: { user: valid_attributes }
#         expect(response).to redirect_to(root_path)
#       end
#     end

#     context "with invalid params" do
#       it "renders a JSON response with errors" do
#         post :create, params: { user: { email: nil } }
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.content_type).to eq('application/json; charset=utf-8')
#       end
#     end
#   end
# end
