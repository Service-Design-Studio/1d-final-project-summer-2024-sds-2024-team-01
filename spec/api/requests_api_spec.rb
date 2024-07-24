require 'rails_helper'

describe 'Requests API', type: :request do
    it 'returns all requests' do
      get '/api/v3/requests'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(0)
    end
end