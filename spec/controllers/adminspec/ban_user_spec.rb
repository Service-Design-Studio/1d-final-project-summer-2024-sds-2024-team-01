# spec/controllers/admin/ban_user_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::BanUserController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:under_review_report) { create(:user_report, reported_user: user, status: 'under_review') }
  let(:banned_report) { create(:user_report, reported_user: user, status: 'ban') }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "assigns under_review_users and banned_users" do
      under_review_report
      banned_report
      get :index
      expect(assigns(:under_review_users)).to eq([user])
      expect(assigns(:banned_users)).to eq([user])
    end
  end

  describe "POST #ban" do
    context "when the user is under review" do
      before { under_review_report }

      it "bans the user and sends notification and email" do
        expect_any_instance_of(Admin::BanUserController).to receive(:send_notification_and_email).with(user, 'You have been banned from the web app.')

        post :ban, params: { id: user.id }
        under_review_report.reload
        expect(under_review_report.status).to eq('ban')
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to eq("#{user.name} has been banned.")
      end
    end

    context "when the user is not under review" do
      it "does not ban the user" do
        post :ban, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["success"]).to be_falsey
      end
    end
  end

  describe "POST #unban" do
    context "when the user is banned" do
      before { banned_report }

      it "unbans the user and sends notification and email" do
        expect_any_instance_of(Admin::BanUserController).to receive(:send_notification_and_email).with(user, 'You have been unbanned from the web app.')

        post :unban, params: { id: user.id }
        banned_report.reload
        expect(banned_report.status).to eq('Active')
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to eq("#{user.name} has been unbanned.")
      end
    end

    context "when the user is not banned" do
      it "does not unban the user" do
        post :unban, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["success"]).to be_falsey
      end
    end
  end

  describe "POST #cancel_ban" do
    context "when the user is under review" do
      before { under_review_report }

      it "cancels the ban and updates the status to Active" do
        post :cancel_ban, params: { id: user.id }
        under_review_report.reload
        expect(under_review_report.status).to eq('Active')
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to eq("No ban placed on #{user.name}.")
      end
    end

    context "when the user is not under review" do
      it "does not cancel the ban" do
        post :cancel_ban, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["success"]).to be_falsey
      end
    end
  end
end
