# # spec/controllers/my_devise/sessions_controller_spec.rb
# require 'rails_helper'

# RSpec.describe MyDevise::SessionsController, type: :controller do
#   let(:user) { create(:user) }

#   describe "POST #create" do
#     context "with valid params" do
#       it "signs in the user" do
#         post :create, params: { user: { email: user.email, password: user.password } }
#         expect(response).to redirect_to(root_path)
#       end
#     end

#     context "with invalid params" do
#       it "renders a JSON response with errors" do
#         post :create, params: { user: { email: user.email, password: "wrongpassword" } }
#         expect(response).to have_http_status(:unauthorized)
#         expect(response.content_type).to eq('application/json; charset=utf-8')
#       end
#     end
#   end

#   describe "DELETE #destroy" do
#     before do
#       sign_in user
#     end

#     it "signs out the user" do
#       delete :destroy
#       expect(response).to redirect_to(root_path)
#     end
#   end
# end
