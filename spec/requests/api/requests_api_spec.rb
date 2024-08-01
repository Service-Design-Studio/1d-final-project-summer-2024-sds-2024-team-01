require 'rails_helper'

describe 'Requests API', type: :request do
  describe 'GET /requests' do
    it 'returns all requests' do
      5.times {FactoryBot.create(:request)}
      get '/api/v3/requests'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe 'GET /requests/:id' do
    it 'returns a specific request' do
      1.times {FactoryBot.create(:request)}
      get '/api/v3/requests#{request.id}'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end