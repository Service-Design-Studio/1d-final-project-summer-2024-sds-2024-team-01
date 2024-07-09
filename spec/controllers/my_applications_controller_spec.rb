# # spec/controllers/my_applications_controller_spec.rb
# require 'rails_helper'

# RSpec.describe MyApplicationsController, type: :controller do
#   let(:user) { create(:user) }
#   let(:request_record) { create(:request, user: user) }
#   let(:request_application) { create(:request_application, applicant: user, request: request_record) }

#   before do
#     sign_in user
#   end

#   describe "GET #index" do
#     it "returns a success response" do
#       get :index
#       expect(response).to be_successful
#     end
#   end

#   describe "GET #show" do
#     it "returns a success response" do
#       get :show, params: { id: request_application.id }
#       expect(response).to be_successful
#     end
#   end
# end
