# spec/mailers/company_mailer_spec.rb
require "rails_helper"

RSpec.describe CompanyMailer, type: :mailer do
  describe 'approval_email' do
    let(:company) { create(:company, email: 'test@example.com') }
    let(:code) { 'unique_code_123' }
    let(:mail) { CompanyMailer.with(company: company, code: code).approval_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your company has been approved')
      expect(mail.to).to eq([company.email])
      expect(mail.from).to eq(['from@example.com']) # Change to your default from email
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Your company has been approved')
      expect(mail.body.encoded).to match(code)
    end
  end
end
