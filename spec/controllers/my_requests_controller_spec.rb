require 'rails_helper'

RSpec.describe 'MyRequestsController', type: :controller do
  let(:role) { create(:role) }
  let(:requester) { create(:requester) }
  let(:request) { create(:test_request, created_by: requester) }

  describe 'Marking a request as complete' do
    before do
      sign_in requester
    end

    context 'When marking a request as complete' do
      it "updates it's status from pending to complete" do
        post :complete, params: { id: request.id }
      end
      it 'is now marked as complete' do
        expect(request.status).to eq('complete')
      end
    end
  end

  #   describe 'Accepting a request' do
  #     before do
  #     end
  #     context 'When accepting an application' do
  #       it "updates it's status from pending to accepted"
  #       expect
  #     end
  #   end
  #
  #   describe 'Accepting a request' do
  #     before do
  #     end
  #     context 'When accepting an application' do
  #       it "updates it's status from pending to accepted"
  #       expect
  #     end
  #   end
end
