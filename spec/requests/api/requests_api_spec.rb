require 'rails_helper'
require 'spec_helper'

context 'when calling the Requests API', type: :request do
  before(:all) do
    5.times {FactoryBot.create(:request)}
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
  end

  describe 'PATCH /requests/:id' do
    it 'updates an existing request' do
      patch "/api/v3/requests/#{@id_of_request}", params: {request: {
                                                                    number: @phone_number,
                                                                    password: @password,
                                                                    description: "I need someone to trim my bushes \n I have changed the date and no. of pax",
                                                                    date: '2024-10-16',
                                                                    number_of_pax: 2,
                                                                    }} 
      expect(JSON.parse(response.body)['description']).to eq("I need someone to trim my bushes \n I have changed the date and no. of pax")
      expect(JSON.parse(response.body)['date']).to eq("2024-10-16")
      expect(JSON.parse(response.body)['number_of_pax']).to eq(2)
      expect(DateTime.parse(JSON.parse(response.body)['updated_at']).min).to eq(Request.last.updated_at.min)
      expect(response).to have_http_status(:ok)
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
  end
end