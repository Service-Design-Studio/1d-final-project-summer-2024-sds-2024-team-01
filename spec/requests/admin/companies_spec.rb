require 'rails_helper'

RSpec.describe "Admin::Companies", type: :request do
  describe "GET /approve" do
    it "returns http success" do
      get "/admin/companies/approve"
      expect(response).to have_http_status(:success)
    end
  end

end
