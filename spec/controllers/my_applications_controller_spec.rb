require 'rails_helper'

RSpec.describe MyApplicationsController, type: :controller do


  describe "GET /index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "returns an unsuccessful response" do
      allow(controller).to receive(:index).and_raise(StandardError)
      expect { get :index }.to raise_error(StandardError)
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get :show, params: { id: request_application.id }
      expect(response).to be_successful
    end

    it "returns an unsuccessful response" do
      expect { get :show, params: { id: 0 } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
