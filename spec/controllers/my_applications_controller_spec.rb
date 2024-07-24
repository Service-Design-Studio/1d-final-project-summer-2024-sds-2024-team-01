# spec/controllers/my_applications_controller_spec.rb

require 'rails_helper'

RSpec.describe MyApplicationsController, type: :controller do
  let(:user) { create(:random_user) } # Assuming you have a factory for User
  let(:request) { create(:test_request) } # Assuming you have a factory for User

  before { sign_in user }

  describe 'GET #index' do
    context 'in HTML' do
      it 'assigns @applications with withdrawn applications belonging to current_user' do
        application = create(:random_application, applicant_id: user.id, status: 'Withdrawn')
        get :index, params: { tab: 'withdrawn' }

        expect(assigns(:applications)).to match_array([application])
      end

      it 'assigns @applications with completed applications belonging to current_user' do
        application = create(:random_application, request: create(:request, status: 'Completed'), applicant_id: user.id, status: 'Accepted')
        get :index, params: { tab: 'completed' }
        expect(assigns(:applications)).to match_array([application])
      end

      it 'assigns @applications with pending applications belonging to current_user' do
        application = create(:random_application, applicant_id: user.id, status: 'Pending')
        get :index, params: { tab: 'pending' }

        expect(assigns(:applications)).to match_array([application])
      end

      it 'assigns @applications with upcoming applications belonging to current_user' do
        application = create(:random_application, applicant_id: user.id, status: 'Accepted')
        get :index, params: { tab: 'upcoming' }

        expect(assigns(:applications)).to match_array([application])
      end

      context 'in JSON' do
        it 'renders the stuff in json' do
          get :index, params: { tab: 'upcoming' }, format: :json
          rendered_partial = MyApplicationsController.render(
            partial: 'request_cards',
            locals: { requests: @applications },
            formats: [:html]
          )
          json_response = JSON.parse(response.body)
          expect(json_response['html']).to eq(rendered_partial)
        end
      end
    end
  end

  describe 'POST #withdraw' do
    it 'updates the status of the application to "Withdrawn"' do
      application = create(:random_application, applicant_id: user.id)
      post :withdraw, params: { id: application.id }
      application.reload
      puts application.status
      expect(application.status).to eq('Withdrawn')
    end

    it 'fails when missing a required field' do
      allow_any_instance_of(RequestApplication).to receive(:save).and_return(false)
      application = create(:random_application, applicant_id: user.id)
      post :withdraw, params: { id: application.id }
      expect(application.status).to_not eq('Withdrawn')
    end
  end
end
