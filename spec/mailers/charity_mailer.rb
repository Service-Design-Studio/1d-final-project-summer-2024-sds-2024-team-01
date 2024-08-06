require 'rails_helper'

RSpec.describe CharityMailer, type: :mailer do
  describe 'approval_email' do
    let(:charity) { create(:charity) }
    let(:charity_manager) { create(:user, charity: charity, role_id: 5) } # Assuming role_id 5 is for charity manager
    let(:mail) { described_class.with(charity: charity, code: 'unique_code').approval_email.deliver_now }

    before do
      charity_manager # Ensure the charity manager is created
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Your Charity has been Approved')
      expect(mail.to).to eq([charity_manager.email])
      expect(mail.from).to eq(['no-reply@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('We are pleased to inform you that your charity')
      expect(mail.body.encoded).to match('has been approved')
      expect(mail.body.encoded).to match('Your approval code is: unique_code')
    end
  end
end
