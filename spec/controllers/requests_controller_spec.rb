# spec/controllers/requests_controller_spec.rb
require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:user) { create(:user) }
  let(:request_record) { create(:request, user: user) }
  let(:valid_attributes) {
    {
      title: "Updated Title",
      category: "Teaching",
      location: "Updated Location",
      date: Date.today,
      number_of_pax: 3,
      duration: 4,
      reward_type: "Yes",
      status: "Updated Status",
      created_by: "Updated User",
      start_time: "10:00",
      end_time: "14:00",
      description: "Updated description",
      reward: "Yes",
      reward_description: "Free lunch"
    }
  }
  let(:invalid_attributes) {
    {
      title: "",
      date: nil
    }
  }

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: request_record.to_param }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested request" do
        put :update, params: { id: request_record.to_param, request: valid_attributes }
        request_record.reload
        expect(request_record.title).to eq("Updated Title")
        expect(request_record.description).to eq("Updated description")
      end

      it "redirects to the request" do
        put :update, params: { id: request_record.to_param, request: valid_attributes }
        expect(response).to redirect_to(request_record)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { id: request_record.to_param, request: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
