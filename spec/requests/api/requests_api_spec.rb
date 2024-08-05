require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V3::RequestsController do
  context 'when calling the Requests API', type: :request do
    before(:all) do
      5.times {FactoryBot.create(:request)}
      # 3.times {FactoryBot.create(:charity)}
      @request = Request.last
      @id_of_request = @request.id
      @created_user = User.last
      @phone_number = @created_user.number
      @password = "password"
      # p @phone_number, @password
    end

    describe 'GET /requests' do
      it 'returns all requests' do
        get '/api/v3/requests'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end

    describe 'GET /requests/:id' do
      it 'returns a specific request' do
        get "/api/v3/requests/#{@id_of_request}"
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['id']).to eq(@id_of_request)
      end

      it 'fails to return a specific request' do 
        get "/api/v3/requests/#{@id_of_request+1}"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq("Request does not exist.")
      end
    end

    describe 'POST /requests' do
      it 'creates a new request' do
        expect{
          post '/api/v3/requests', params: {request: {number: @phone_number,
                                                      password: @password,
                                                      title: 'Need help with mowing lawn',
                                                      description: 'I need someone to trim my bushes',
                                                      category: 'Gardening',
                                                      location: '0020000001000010e64059fd604189374c3ff4d0e560418937',
                                                      stringlocation: '10 Downing Street',
                                                      date: '2024-08-16',
                                                      start_time: '10:00:00',
                                                      number_of_pax: 4,
                                                      duration: 3,
                                                      reward_type: "None",
                                                      reward: "None"
                                                      }}
        }.to change {Request.count}.from(5).to(6)
        expect(response).to have_http_status(:created)
      end

      context 'fails to create a new request' do
        it 'due to invalid username or password' do 
          post '/api/v3/requests', params: {request: {number: "",
                                                      password: "",
                                                      title: 'Need help with mowing lawn',
                                                      description: 'I need someone to trim my bushes',
                                                      category: 'Gardening',
                                                      location: '0020000001000010e64059fd604189374c3ff4d0e560418937',
                                                      stringlocation: '10 Downing Street',
                                                      date: '2024-08-16',
                                                      start_time: '10:00:00',
                                                      number_of_pax: 4,
                                                      duration: 3,
                                                      reward_type: "None",
                                                      reward: "None"
                                                      }}
          expect(response).to have_http_status(:unauthorized)
        end

        it 'due to missing value' do 
          post '/api/v3/requests', params: {request: {number: @phone_number,
                                                      password: @password,
                                                      title: "",
                                                      description: 'I need someone to trim my bushes',
                                                      category: 'Gardening',
                                                      location: '0020000001000010e64059fd604189374c3ff4d0e560418937',
                                                      stringlocation: '10 Downing Street',
                                                      date: '2024-08-16',
                                                      start_time: '10:00:00',
                                                      number_of_pax: 4,
                                                      duration: 3,
                                                      reward_type: "None",
                                                      reward: "None"
                                                      }}
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'due to unknown errors' do 
          post '/api/v3/requests', params: {request: {number: @phone_number,
                                                      password: @password,
                                                      title: 'Need help with mowing lawn',
                                                      description: 'I need someone to trim my bushes',
                                                      category: 'Gardening',
                                                      location: '0020000001000010e64059fd604189374c3ff4d0e560418937',
                                                      stringlocation: '10 Downing Street',
                                                      date: '2024-08-16',
                                                      number_of_pax: 4,
                                                      duration: 3,
                                                      reward_type: "None",
                                                      reward: "None"
                                                      }}
          expect(response).to have_http_status(:internal_server_error)
        end
      end
    end

    describe 'PATCH /requests/:id' do
      it 'updates an existing request' do
        patch "/api/v3/requests/#{@id_of_request}", params: {request: {
                                                                      number: @phone_number,
                                                                      password: @password,
                                                                      description: "I need someone to trim my bushes \n I have changed the date and no. of pax",
                                                                      date: '2024-10-16',
                                                                      number_of_pax: 2
                                                                      }} 
        expect(JSON.parse(response.body)['description']).to eq("I need someone to trim my bushes \n I have changed the date and no. of pax")
        expect(JSON.parse(response.body)['date']).to eq("2024-10-16")
        expect(JSON.parse(response.body)['number_of_pax']).to eq(2)
        expect(DateTime.parse(JSON.parse(response.body)['updated_at']).min).to eq(Request.last.updated_at.min)
        expect(response).to have_http_status(:ok)
      end

      context 'fails to update existing request' do 
        it 'due to unknown errors' do
          patch "/api/v3/requests/#{@id_of_request}", params: {rquest: {number: @phone_number,
                                                                      password: @password
                                                                      }} 
          expect(response).to have_http_status(:internal_server_error)
        end
        
        it 'due to missing values' do
          patch "/api/v3/requests/#{@id_of_request}", params: {request: {
                                                                      number: @phone_number,
                                                                      password: @password,
                                                                      description: "I need someone to trim my bushes \n I have changed the date and no. of pax",
                                                                      date: "",
                                                                      number_of_pax: 2
                                                                      }} 
          expect(response).to have_http_status(:unprocessable_entity)                                            
        end

        it 'due to invalid username or password' do 
          patch "/api/v3/requests/#{@id_of_request}", params: {request: {
                                                                      number: "",
                                                                      password: @password,
                                                                      description: "I need someone to trim my bushes \n I have changed the date and no. of pax",
                                                                      date: "2024-10-16",
                                                                      number_of_pax: 2
                                                                      }}
          expect(response).to have_http_status(:unauthorized)
        end

        it 'due to missing request' do
          patch "/api/v3/requests/#{@id_of_request+1}", params: {request: {
            number: @phone_number,
            password: @password,
            description: "I need someone to trim my bushes \n I have changed the date and no. of pax",
            date: "2024-10-16",
            number_of_pax: 2
        }}
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)['message']).to eq("Request does not exist.")
        end
      end
    end

    describe 'DELETE /requests/:id' do 
      it 'deletes an existing request' do
        expect{delete "/api/v3/requests/#{@id_of_request}", params: {request: {number: @phone_number,
                                                                              password: @password,
                                                                              title: "Need help with mowing lawn"
                                                                              }}}.to change {Request.count}.from(5).to(4)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).not_to eq(Request.where(request_id: 5))
      end

      context 'fails to delete an existing request' do 
        it 'due to invalid username or password' do
          delete "/api/v3/requests/#{@id_of_request}", params: {request: {numer: @phonenumber,
                                                                      passwod: @passwor,
                                                                      tite: 1234
                                                                      }} 
          expect(response).to have_http_status(:unauthorized)
        end

        it 'due to missing request' do
          delete "/api/v3/requests/#{@id_of_request+1}", params: {request: {
            number: @phone_number,
            password: @password
        }}
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)['message']).to eq("Request does not exist.")
        end
        
      end
    end
  end

  context "apply using the requests API" do 
    let(:user) { create(:user) }
    let(:company_user) { create(:user, role_id: 4, company_id: create(:company).id) }      
    let(:ipc_user) { create(:user, role_id: 5, charity_id: create(:charity).id) }
    let(:request) { create(:request, created_by: ipc_user.id, number_of_pax: 2) }
              
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    

    describe "POST /api/v3/requests/:id/apply" do
      context "when user is not a company user" do
        it "allows application" do
          post "/api/v3/requests/#{request.id}/apply"
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)["message"]).to eq("You have successfully applied for the request!")
        end
  
        it "prevents duplicate applications" do
          create(:request_application, applicant_id: user.id, request_id: request.id)
          post "/api/v3/requests/#{request.id}/apply"
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)["notice"]).to eq("You have already applied for this request.")
        end
  
        it "prevents application when request is full" do
          create_list(:request_application, 2, request_id: request.id, status: 'Accepted')
          post "/api/v3/requests/#{request.id}/apply"
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)["notice"]).to eq("Sorry, this request is unable to accept anymore applicants.")
        end
      end
  
      context "when user is a company user" do
        before do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(company_user)
        end
  
        it "allows application for registered IPC" do
          create(:company_charity, company_id: company_user.company_id, charity_id: ipc_user.charity_id)
          post "/api/v3/requests/#{request.id}/apply"
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)["message"]).to eq("You have successfully applied for the request!")
        end
  
        it "prevents application for unregistered IPC" do
          post "/api/v3/requests/#{request.id}/apply"
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)["notice"]).to eq("You can only apply for requests by IPCs registered with your company")
        end
      end
  
      it "creates a notification for the request creator" do
        expect {
          post "/api/v3/requests/#{request.id}/apply"
        }.to change(Notification, :count).by(1)
  
        notification = Notification.last
        expect(notification.message).to eq("Someone has applied for your request! Click here to view.")
        expect(notification.notification_for).to eq(ipc_user)
      end
  
      it "handles failed application save" do
        allow_any_instance_of(RequestApplication).to receive(:save).and_return(false)
        post "/api/v3/requests/#{request.id}/apply"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["notice"]).to eq("Sorry, you have failed to apply for this request.")
      end
    end
  end
end