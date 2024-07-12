require 'rails_helper'

RSpec.describe "RequestsController", type: :controller do
  describe "GET /index" do
    expect(response).to render_template(:index)
  end

  describe "GET /show" do
    expect(response).to render_template(:show)
  end

  describe "POST /apply" do
    sign_in 
    expect(response).to render_template(:new)
  end

  describe "POST /create" do
    pending "add some examples (or delete) #{__FILE__}"
    post :create, :params => { :name => "Any Name" }
    expect(response.status).to eq(200)
  end

  describe "POST /apply" do
    pending "add some examples (or delete) #{__FILE__}"
    login_as(applicant)
    post :create, :params => { :name => "Any Name" }
    expect(response.status).to eq(200)
  end

  describe "POST /destroy" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
