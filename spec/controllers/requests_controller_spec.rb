# spec/controllers/requests_controller_spec.rb

require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:testfile) { fixture_file_upload('app/assets/images/freepik-lmao.jpg', 'image/jpeg') }
  let(:company) { create(:random_company) }
  let(:charity) { create(:random_charity) }
  let(:char_comp_assoc) { create(:random_company_charity, company_id: company.id, charity_id: charity.id) }
  let(:user) { create(:user) }
  let(:charuser) { create(:user, role_id: 5, charity_id: charity.id) }
  let(:corp) { create(:user, role_id: 4, company_id: company.id) }
  let(:valid_attributes) { attributes_for(:request, created_by: user.id, thumbnail: testfile) }
  let(:valid_attributes_no_thumb) { attributes_for(:request, created_by: user.id) }
  let(:invalid_attributes) { attributes_for(:request, title: nil, created_by: user.id) }

  context 'unauthenticated user' do
    describe 'GET #index' do
      it 'assigns @requests with requests to user ' do
        create(:request)
        get :index
        expect(assigns(:in_progress_requests).length).to eq(1)
      end
    end

    describe 'GET #show on a non existent request' do
      it 'assigns @requests with requests to user ' do
        get :show, params: { id: 'hehe' }
        expect(flash[:notice]).to eq('This request does not exist')
      end
    end
  end
  context 'corporate user' do
    before do
      sign_in corp
    end
    describe 'GET #index' do
      it 'assigns @requests with requests to user ' do
        puts char_comp_assoc.charity_id
        create(:request, created_by: charuser.id)
        create(:request)
        get :index
        expect(assigns(:in_progress_requests).length).to eq(1)
        expect(Request.count).to eq(2)
      end
    end
  end
  context 'normal user' do
    before do
      sign_in user
    end
    describe 'GET #index' do
      it 'assigns @requests with requests to user ' do
        create(:request)
        create(:request, reward_type: 'Cash', reward: '$50')
        get :index
        expect(assigns(:in_progress_requests).length).to eq(2)
      end
    end

    describe 'GET #show' do
      # alr have request created
      let(:request) { create(:request, created_by: user.id) }

      it 'returns a success response' do
        get :show, params: { id: request.id }
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get :new
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid params ' do
        it 'creates a new Request with a thumbnail image' do
          expect do
            post :create, params: { request: valid_attributes }
          end.to change(Request, :count).by(1)
          expect(response).to redirect_to(Request.last)
          expect(flash[:notice]).to eq('Request was successfully created.')
          expect(Request.last.thumbnail).to be_attached
        end

        it 'creates a new request without a thumbnail' do
          expect do
            post :create, params: { request: valid_attributes_no_thumb }
          end.to change(Request, :count).by(1)
          expect(response).to redirect_to(Request.last)
          expect(flash[:notice]).to eq('Request was successfully created.')
        end
      end

      context 'with invalid params' do
        it 'renders the new template with unprocessable entity status' do
          post :create, params: { request: invalid_attributes }
          expect(response).to render_template(:new)
          expect(response.status).to eq(422)
        end
      end
    end

    describe 'GET #edit' do
      let(:request) { create(:request, created_by: user.id) }

      it 'returns a success response' do
        get :edit, params: { id: request.id }
        expect(response).to be_successful
      end
    end

    # describe 'PATCH/PUT #update' do
    #   let(:request) { create(:request, created_by: user.id) }
    #   let(:new_attributes) { { title: 'Updated Title' } }
    #
    #   context 'with valid params' do
    #     it 'updates the requested request' do
    #       patch :update, params: { id: request.id, request: new_attributes }
    #       request.reload
    #       expect(request.title).to eq('Updated Title')
    #     end
    #
    #     it 'redirects to the request' do
    #       patch :update, params: { id: request.id, request: new_attributes }
    #       expect(response).to redirect_to(request)
    #     end
    #   end
    #
    #   context 'with invalid params' do
    #     it 'renders the edit template with unprocessable entity status' do
    #       patch :update, params: { id: request.id, request: { title: nil } }
    #       expect(response).to render_template(:edit)
    #       expect(response.status).to eq(422)
    #     end
    #   end
    # end

    describe 'POST #apply' do
      let(:request) { create(:request, number_of_pax: 1) }

      context 'when all the params are not fulfilled somehow' do
        it 'fails to save the application' do
          allow_any_instance_of(RequestApplication).to receive(:save).and_return(false)

          expect do
            post :apply, params: { id: request.id }
          end.to change(RequestApplication, :count).by(0)
        end
      end

      context 'when the user has not applied before' do
        it 'creates a new RequestApplication' do
          expect do
            post :apply, params: { id: request.id }
          end.to change(RequestApplication, :count).by(1)
          expect(RequestApplication.last.applicant_id).to eq(user.id)
          expect(RequestApplication.last.request_id).to eq(request.id)
        end

        it 'redirects to the request with a success notice' do
          post :apply, params: { id: request.id }
          expect(response).to redirect_to(request)
          expect(flash[:notice]).to eq('You have successfully applied for the request!')
        end
      end

      context 'when the user has already applied' do
        before do
          create(:application, applicant_id: user.id, request_id: request.id)
        end

        it 'does not create a new RequestApplication' do
          expect do
            post :apply, params: { id: request.id }
          end.not_to change(RequestApplication, :count)
        end

        it 'redirects to the request with an alert' do
          post :apply, params: { id: request.id }
          expect(response).to redirect_to(request)
          expect(flash[:notice]).to eq('You have already applied for this request.')
        end
      end

      context 'when the request is already full' do
        before do
          create(:random_application, status: 'Accepted', request_id: request.id)
        end

        it 'does not create a new RequestApplication' do
          post :apply, params: { id: request.id }
          expect(flash[:notice]).to eq('Sorry, this request is unable to accept anymore applicants.')
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:request) { create(:request, created_by: user.id) }

      it 'destroys the requested request' do
        expect do
          delete :destroy, params: { id: request.id }
        end.to change(Request, :count).by(-1)
      end

      it 'redirects to the requests list' do
        delete :destroy, params: { id: request.id }
        expect(response).to redirect_to('/requests')
        expect(flash[:notice]).to eq('Request was successfully destroyed.')
      end
    end
  end
end
