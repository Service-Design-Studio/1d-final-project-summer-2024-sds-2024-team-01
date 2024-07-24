# spec/controllers/my_applications_controller_spec.rb

require 'rails_helper'

RSpec.describe MyApplicationsController, type: :controller do
  let(:user) { create(:random_user) } # Assuming you have a factory for User
  let(:request) { create(:test_request) } # Assuming you have a factory for User

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns @applications with applications belonging to current_user' do
      application = create(:random_application, applicant_id: user.id)
      get :index
      expect(assigns(:applications)).to match_array([application])
    end
    # Add more specific tests as needed
  end

  # There isn't really a need for a show action
  # describe 'GET #show' do
  #   let(:application) { create(:random_application, applicant_id: user.id) }
  #
  #   it 'assigns @application with the correct application' do
  #     get :show, params: { id: application.id }
  #     expect(assigns(:application)).to eq(application)
  #   end
  #
  #   # Add more specific tests as needed
  # end
end
