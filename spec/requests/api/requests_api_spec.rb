require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V3::RequestsController do
  before(:all) do
    5.times {FactoryBot.create(:request)}
    @request = Request.last
    @id_of_request = @request.id
    @created_user = User.last
    @phone_number = @created_user.number
    @password = "password"
    # p @phone_number, @password
  end

  context 'when calling the Requests API', type: :request do
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


end