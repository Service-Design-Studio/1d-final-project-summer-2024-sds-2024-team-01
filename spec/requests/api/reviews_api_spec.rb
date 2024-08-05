require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V3::ReviewsController do 
  context 'when calling the Reviews API', type: :controller do 
    before(:all) do 
      5.times {FactoryBot.create(:user)}
      

    end 

    describe 'GET /reviews' do
      it 'returns all reviews' do 
        get '/api/v3/reviews'
        expect(response).to have_http_status(:success)
      end
    end
  end
end